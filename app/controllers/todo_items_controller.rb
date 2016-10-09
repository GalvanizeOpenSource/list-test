class TodoItemsController < ApplicationController

  def index
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def new
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
      @todo_item = @todo_list.todo_items.new
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
      @todo_list = TodoList.find(params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def update
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])

      if @todo_item.update_attributes(todo_item_params)
        flash[:success] = "Saved todo list item."
        redirect_to todo_list_todo_items_path
      else
        flash[:error] = "That todo item could not be saved."
        render action: :edit
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def destroy
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = TodoItem.find(params[:id])

    @todo_item.destroy
    check_todo_list
    respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Created a new method which does a check on the todo_list
  # This will be called when the destroy method is called on a todo_item
  # If there are no more items left in the todo_list, destroy the todo_list
  def check_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
    if @todo_list.todo_items.none?
      @todo_list.destroy
      flash[:success] = "The last todo item was successfully removed and your todo list was deleted."
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

