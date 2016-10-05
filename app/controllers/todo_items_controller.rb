class TodoItemsController < ApplicationController
  def index
    begin
      @todo_list = TodoList.find_by!(id: params[:todo_list_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def new
    begin
      @todo_list = TodoList.find_by!(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.new
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def create
    begin
      @todo_list = TodoList.find_by!(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.new(todo_item_params)

      # Needed to append to due_date string to ensure due_date
      # is properly converted to UTC when it hits the database
      @todo_item.timezone_offset = cookies['timeZoneOffset']
      # Needed to allow both blank and non-blank due date validation.
      # ActiveRecord does not allow setting of invalidate DateTimes
      # to a DateTime field, it defaults to nil.  So the validation
      # needs to take place here and the result passed to the model
      # so validation errors can be created.
      @todo_item.due_date_valid  = due_date_valid?
      
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
      @todo_list = TodoList.find_by!(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def update
    begin
      @todo_list = TodoList.find_by!(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])

      @todo_item.timezone_offset = cookies['timeZoneOffset']
      @todo_item.due_date_valid  = due_date_valid?

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

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def todo_item_params
    params[:todo_item].permit(:content, :due_date, :done)
  end

  def due_date_valid?
    return true if params[:todo_item][:due_date].blank?
    d = Date.parse(params[:todo_item][:due_date]) rescue nil
    !!d
  end

end
