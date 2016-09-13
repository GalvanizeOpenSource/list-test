module Api
  class DueItemsController < ::ApplicationController
    def index
      render json: { todo_items: todo_items }, status: :ok
    end

    private

    def todo_items
      @todo_items ||= TodoItem.due_in(10.minutes)
    end
  end
end
