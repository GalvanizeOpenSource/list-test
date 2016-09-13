module Api
  class TodoItemsController < ::ApplicationController
    def create
      todo_item = todo_items.new(permitted_params)

      if todo_item.save
        default_message = "Saved todo list item."
        render json: { todo_item: todo_item, message: default_message }, status: :ok
      else
        render json: { errors: todo_item.errors.full_messages }, status: :unprocessible_entity
      end
    rescue NoMethodError, ActiveRecord::RecordNotFound
      render json: { errors: "Unable to find todo list to add item to." }, status: :unprocessible_entity
    end

    private

    def permitted_params
      params.permit(:content)
    end

    def todo_items
      @todo_items ||= todo_list.todo_items
    end

    def todo_list
      @todo_list ||= TodoList.find_by(id: params[:todo_list_id])
    end
  end
end
