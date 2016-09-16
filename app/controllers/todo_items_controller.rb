class TodoItemsController < ApplicationController
  # As an alternative to before_actions, we can use local variables which IMO is much cleaner and explicit which is nice.
  # Here are some references:
  # https://forum.upcase.com/t/memoized-helper-methods-instead-of-instance-variables-in-controllers/5848
  # https://thoughtbot.com/upcase/videos/encapsulation-and-global-state-in-rails
  before_action :set_todo_list, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_todo_items, only: [:index]
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

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def set_todo_list
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
    rescue ActiveRecord::RecordNotFound, NoMethodError
      redirect_to new_todo_list_path
    end
  end

  def set_todo_items
    begin
      @todo_items = @todo_list.todo_items
      @todo_items = @todo_items.order_due_by + @todo_items.order_alphabetically
    rescue ActiveRecord::RecordNotFound, NoMethodError
      redirect_to new_todo_list_path
    end
  end

  def set_todo_item
    begin
      @todo_item = @todo_list.todo_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound, NoMethodError
      redirect_to new_todo_list_path
    end
  end

  def todo_item_params
    params[:todo_item].permit(:content, :due_by)
  end
end
