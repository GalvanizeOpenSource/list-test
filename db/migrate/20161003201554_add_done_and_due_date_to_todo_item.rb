class AddDoneAndDueDateToTodoItem < ActiveRecord::Migration
  def change
  	add_column :todo_items, :done, :boolean, default: false
  	add_column :todo_items, :due_date, :datetime
  end
end
