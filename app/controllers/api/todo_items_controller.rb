module Api
  class TodoItemsController < ::ApplicationController
    def create
      return render_error if todo_list.nil?

      todo_item = todo_items.new(permitted_params)

      if todo_item.save
        default_message = "Saved todo list item."
        render json: { todo_item: todo_item, message: default_message }, status: :ok
      else
        render json: { errors: todo_item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def render_error
      render json: { errors: "Unable to find todo list to add item to." }, status: :unprocessable_entity
    end

    def permitted_params
      params.permit(:content)
    end

    def todo_items
      @todo_items ||= todo_list.todo_items if todo_list
    end

    def todo_list
      @todo_list ||= TodoList.find_by(id: params[:todo_list_id])
    end
  end
end
