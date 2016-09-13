module Api
  class TodoItemStateController < ::ApplicationController
    before_filter :check_record_presence, only: [:update]

    def update
      begin
        # TODO: Add some logging code
        todo_item.toggle_state!
        render json: { todo_item: todo_item }, status: :ok
      rescue ActiveRecord::RecordNotFound,
             ActiveRecord::Rollback,
             ActiveRecord::RecordInvalid
        error_text = "Sorry, we could not mark your todo item as done"
        render json: { errors: todo_item.errors.full_messages, error_text: error_text }, status: :unprocessible_entity
      end
    end

    private

    def check_record_presence
      raise ActiveRecord::RecordNotFound if todo_list.nil? || todo_item.nil?
    end

    def todo_list
      @todo_list ||= TodoList.find_by(id: params[:todo_list_id])
    end

    def todo_items
      @todo_items ||= todo_list.todo_items
    end

    def todo_item
      @todo_item ||= todo_items.find(params[:id])
    end
  end
end
