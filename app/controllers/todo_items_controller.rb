class TodoItemsController < ApplicationController
  def index
    begin
      if TodoList.exists?(id: params[:todo_list_id])
        @todo_list = TodoList.find_by(id: params[:todo_list_id])
      else
        redirect_to new_todo_list_path
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def new
    begin
      if TodoList.exists?(id: params[:todo_list_id])
        @todo_list = TodoList.find_by(id: params[:todo_list_id])
        @todo_item = @todo_list.todo_items.new
      else
        redirect_to new_todo_list_path
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

  def destroy
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.destroy(params[:id])
      length = @todo_list.todo_items.reload.length
      if length == 0
        @todo_list.destroy
        flash[:success] = "The last todo item was successfully removed and your todo list was deleted."
        redirect_to todo_lists_url
      else
        flash[:success] = "Your todo item was successfully removed."
        redirect_to todo_list_todo_items_path
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Sorry, there was a problem deleting your todo item."
      redirect_to new_todo_list_path
    end
  end


  def edit
    begin
      if TodoList.exists?(id: params[:todo_list_id])
        @todo_list = TodoList.find_by(id: params[:todo_list_id])
        @todo_item = @todo_list.todo_items.find(params[:id])
      else
        redirect_to new_todo_list_path
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def update
    begin
      if TodoList.exists?(id: params[:todo_list_id])
        @todo_list = TodoList.find_by(id: params[:todo_list_id])
        @todo_item = @todo_list.todo_items.find(params[:id])
        if @todo_item.update_attributes(todo_item_params)
          flash[:success] = "Saved todo list item."
          redirect_to todo_list_todo_items_path
        else
          flash[:error] = "That todo item could not be saved."
          render action: :edit
        end
      else
        redirect_to new_todo_list_path
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
