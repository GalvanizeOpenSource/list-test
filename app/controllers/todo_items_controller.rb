class TodoItemsController < ApplicationController
  before_action :ensure_todo_list, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_todo_item, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)

    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "There was a problem adding that todo list item."
      render action: :new
    end
  end

  def edit
  end

  def update
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = "Saved todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "That todo item could not be saved."
      render action: :edit
    end
  end

  def destroy
    if todo_item_deletion.perform
      flash[:success] = todo_item_deletion.success_message
      redirect_to root_path
    else
      flash[:error] = "Sorry, there was a problem deleting the todo item."
      redirect_to todo_list_todo_items_path(@todo_list)
    end
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def todo_item_params
    params[:todo_item].permit(:content)
  end

  def ensure_todo_list
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_deletion
    @todo_item_deletion ||= Services::TodoItemDeletion.new(@todo_list, @todo_item)
  end
end
