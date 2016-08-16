class TodoItemsController < ApplicationController
  before_action :get_todo_list

  def index
    begin
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
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
    @todo_item = @todo_list.todo_items.find(params[:id])
    # begin
    #   @todo_list = TodoList.find_by(id: params[:todo_list_id])
     
    # rescue ActiveRecord::RecordNotFound
    #   redirect_to new_todo_list_path
    # end
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

  # Add the ability to delete a todo item from the todo_item#index page
  def destroy
    @message = "Your todo item was successfully removed"
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.destroy
    @items_length = TodoList.find_by(id: params[:todo_list_id]).todo_items.length
    
    if !@todo_item.destroyed?
      flash[:error] = "Item was not deleted"
      render action: :index
    end 

    # check if was last item in that list
    if @items_length < 1
      @message = "The last todo item was successfully removed and your todo list was deleted."
      @todo_list.destroy
    end
    
    # after message is set redirect to root path
    respond_to do |format|
      format.html { redirect_to root_path, notice: @message }
      format.json { head :no_content }
    end 
  end

  def url_options
    {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  private
    def get_todo_list
      @todo_list = TodoList.find_by(id: params[:todo_list_id])

      if @todo_list.nil?
        flash[:notice] = "Could not find list"
        redirect_to new_todo_list_path
      end
    end

    def todo_item_params
      params[:todo_item].permit(:content)
    end
end
