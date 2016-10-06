class TodoItemsController < ApplicationController
  def index
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path and return
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
      redirect_to new_todo_list_path and return
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
    todo_item = TodoItem.find(params[:id])
    list = todo_item.todo_list
    if todo_item.destroy
      if list.todo_items.empty?
        list.destroy
        notice = "The last todo item was successfully removed and your todo list was deleted."
      else
        notice =  "Your todo item was successfully removed."
      end
    else
      redirect_to todo_list_todo_items_path, notice: "Sorry, there was a problem deleting the todo item." and return
    end
    redirect_to root_path, notice: notice
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
