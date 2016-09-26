module Services
  class TodoItemDeletion
    attr_reader :success_message

    def initialize(todo_list, todo_item)
      @todo_list = todo_list
      @todo_item = todo_item
    end

    def perform
      todo_list.todo_items.many? ? destroy_item : destroy_list
    end

    private

    attr_reader :todo_list, :todo_item
    attr_writer :success_message

    def destroy_item
      if todo_item.destroy
        self.success_message = "Your todo item was successfully removed."
      else
        false
      end
    end

    def destroy_list
      if todo_list.destroy
        self.success_message = "The last todo item was successfully removed and your todo list was deleted."
      else
        false
      end
    end
  end
end
