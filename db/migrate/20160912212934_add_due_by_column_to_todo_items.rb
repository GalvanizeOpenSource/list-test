class AddDueByColumnToTodoItems < ActiveRecord::Migration
  def up
    add_column :todo_items, :due_by, :datetime
  end

  def down
    remove_column :todo_items, :due_by, :datetime
  end
end
