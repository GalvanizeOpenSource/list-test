class TodoItemsController < ApplicationController
    # before_action :set_todo_list_item, only: [:show, :edit, :update, :destroy]

  def index
    if todo_list
      @todo_list = todo_list
    else
      redirect_to new_todo_list_path
    end
  end

  def new
    if todo_list
      @todo_list = todo_list
      @todo_item = @todo_list.todo_items.new
    else
      redirect_to new_todo_list_path
    end
  end

  def create
    if todo_list
      @todo_list = todo_list
      @todo_item = @todo_list.todo_items.new(todo_item_params)
      if @todo_item.save
        flash[:success] = "Added todo list item."
        redirect_to todo_list_todo_items_path
      else
        flash[:error] = "There was a problem adding that todo list item."
        render action: :new
      end
    else
      redirect_to new_todo_list_path
    end
  end

  def edit
    if todo_list
      set_todo_list_item
    else
      redirect_to new_todo_list_path
    end
  end

  def update
    if todo_list
      set_todo_list_item
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
  end

  def destroy
    set_todo_list_item
    if @todo_item.destroy
      if @todo_list.todo_items.empty?
        @todo_list.destroy
        flash[:success] = "The last todo item was successfully removed and your todo list was deleted"
      else
        flash[:success] = "Your todo item was successfully removed"
      end
      redirect_to root_path
    else
      flash[:error] = "Sorry, there was a problem deleting the todo item"
      redirect_to todo_list_todo_items_path
    end
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private
  def todo_list
    TodoList.find_by(id: params[:todo_list_id])
  end

  def set_todo_list_item
    @todo_list = TodoList.find_by(id: params[:todo_list_id])
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
