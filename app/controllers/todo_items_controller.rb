class TodoItemsController < ApplicationController
  def index
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
      not_null_items = @todo_list.todo_items.where('due_at IS NOT NULL').order('due_at ASC')
      null_items = @todo_list.todo_items.where('due_at IS NULL').order('content')
      @todo_items = not_null_items + null_items

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
        respond_to do |format|
          format.html{
            flash[:success] = "Saved todo list item."
            redirect_to todo_list_todo_items_path
          }
          format.json{
            render json: {success: true}
          }
        end
      else
        respond_to do |format|
          format.html{
            flash[:error] = "That todo item could not be saved."
            render action: :edit
          }
          format.json {
            render json: {error: 'Sorry, we could not mark your todo item as done.'}
          }
        end
      end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
          format.html{
            flash[:error] = "That todo item could not be saved."
            redirect_to new_todo_list_path
          }
          format.json {
            render json: {error: 'Sorry, we could not mark your todo item as done.'}
          }
        end

    end
  end

  def destroy
    begin
      @todo_list = TodoList.find(params[:todo_list_id])
      @todo_item = TodoItem.find(params[:id])

      if @todo_item.destroy
        if @todo_list.reload.todo_items.length == 0
          @todo_list.destroy
          flash[:success] = "The last todo item was successfully removed and your todo list was deleted."
        else
          flash[:success] = "Your todo item was successfully removed."
        end
        redirect_to root_path
      else
        flash[:error] = "Sorry, there was a problem deleting the todo item."
        redirect_to todo_list_todo_items_path(:todo_list_id => @todo_list.id)
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Sorry, there was a problem deleting the todo item."
      redirect_to new_todo_list_path
    end
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private

  def todo_item_params
    params[:todo_item].permit(:content, :due_at, :done)
  end

end
