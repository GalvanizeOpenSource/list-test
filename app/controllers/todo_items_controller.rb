class TodoItemsController < ApplicationController
  def index
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      unless list_exists
        raise ActiveRecord::RecordNotFound
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def new
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      if list_exists
        @todo_item = @todo_list.todo_items.new
      else
        raise ActiveRecord::RecordNotFound
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def create
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
      @todo_item = @todo_list.todo_items.new(todo_item_params)
      if @todo_item.save
        flash[:success] = "Added todo list item."
        redirect_to todo_list_todo_items_path
      else
        flash[:error] = "There was a problem adding that todo list item."
        render action: :new
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def edit
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      if list_exists
        @todo_item = @todo_list.todo_items.find(params[:id])
      else
        raise ActiveRecord::RecordNotFound
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def update
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      if list_exists
        @todo_item = @todo_list.todo_items.find(params[:id])
        if @todo_item.update_attributes(todo_item_params)
          flash[:success] = "Saved todo list item."
          redirect_to todo_list_todo_items_path
        else
          flash[:error] = "That todo item could not be saved."
          render action: :edit
        end
      else
        raise ActiveRecord::RecordNotFound
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def destroy
    @todo_list = TodoList.find_by(id: params[:todo_list_id])
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.destroy
    if @todo_list.todo_items.count <= 0
      destroy_empty_list
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Todo was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  rescue
    flash[:error] = "Sorry, there was a problem deleting the todo item"
    redirect_to root_path
  end

  def destroy_empty_list
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'The last todo item was successfully removed and your todo list was deleted.' }
      format.json { head :no_content }
    end
  rescue
    flash[:error] = "Sorry, there was a problem deleting the todo list"
    redirect_to root_path
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def todo_item_params
    params[:todo_item].permit(:content)
  end

  def list_exists
    !@todo_list.nil?
  end

end
