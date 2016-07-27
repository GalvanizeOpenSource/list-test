class AddDoneToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :done, :boolean, default: false
  end
end
