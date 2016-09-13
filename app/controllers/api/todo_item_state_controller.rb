module Api
  class TodoItemStateController < ::ApplicationController
    def update
      if todo_list.present? && todo_item.present?
        todo_item.toggle_state!
        render json: { todo_item: todo_item }, status: :ok
      else
        render_error
      end
    end

    private

    def render_error
      error_text = "Sorry, we could not mark your todo item as done"
      render json: { error_text: error_text }, status: :unprocessable_entity
    end

    def todo_list
      @todo_list ||= TodoList.find_by(id: params[:todo_list_id])
    end

    def todo_items
      @todo_items ||= todo_list.todo_items if todo_list
    end

    def todo_item
      @todo_item ||= todo_items.find_by(id: params[:id])
    end
  end
end
