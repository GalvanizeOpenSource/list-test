class TodoItemsController < ApplicationController
  def index
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      if @todo_list.blank?
        redirect_to new_todo_list_path
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def new
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
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
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_todo_list_path
    end
  end

  def destroy
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
      @todo_item = @todo_list.todo_items.find(params[:id])
      @todo_item.destroy
      if @todo_item.destroy && @todo_list.todo_items.blank?
        flash[:deleted] = "The last todo item was successfully removed and your todo list was deleted."
        @todo_list.destroy
        redirect_to root_path
      elsif @todo_item.destroy
        flash[:deleted] = "item destoryed."
        redirect_to todo_list_todo_items_path
      else
        flash[:error] = "There was a problem deleting that todo list item."
        redirect_to new_todo_list_path
      end
    rescue ActiveRecord::RecordNotFound
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
