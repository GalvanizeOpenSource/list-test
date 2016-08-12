class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  after_destroy :is_last_item_delete_list

  validates :content, presence: true, length: { minimum: 2 }

  protected
    def is_last_item_delete_list
      list_is_empty = !TodoItem.exists?(todo_list_id: self.todo_list_id)
      if list_is_empty
        @todo_list = TodoList.find_by(id: self.todo_list_id)
        @todo_list.destroy
      end
    end
end
