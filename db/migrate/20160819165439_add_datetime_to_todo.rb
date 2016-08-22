class AddDatetimeToTodo < ActiveRecord::Migration
  def change
    add_column :todo_items, :due_datetime, :datetime
  end
end
