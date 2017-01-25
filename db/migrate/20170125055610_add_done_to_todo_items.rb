class AddDoneToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :done, :boolean, null: false, default: false
  end
end
