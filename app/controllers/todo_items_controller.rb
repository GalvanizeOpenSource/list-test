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
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.new
    rescue
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
      @todo_item = @todo_list.todo_items.find(params[:id])
    rescue
      redirect_to new_todo_list_path
    end
  end

  def update
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])

      if @todo_item.update_attributes(todo_item_params)
        flash[:success] = "Saved todo list item."
        redirect_to todo_list_todo_items_path
      else
        flash[:error] = "That todo item could not be saved."
        render action: :edit
      end
    rescue
      redirect_to new_todo_list_path
    end
  end

  def complete_item
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])

      respond_to do |format|
        if @todo_item.update_attribute(:complete, true)
          format.html { redirect_to todo_list_todo_items_path(@todo_list) }
          format.js
        end
      end

    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Sorry, we could not mark your todo item as done"
      redirect_to todo_list_todo_items_path(@todo_list)
    end
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def todo_item_params
    params[:todo_item].permit(:content, :due_datetime)
  end

end
