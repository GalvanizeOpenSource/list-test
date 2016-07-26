class AddDueAtToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :due_at, :datetime
  end
end
