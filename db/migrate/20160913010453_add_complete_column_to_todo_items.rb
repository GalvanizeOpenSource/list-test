class AddCompleteColumnToTodoItems < ActiveRecord::Migration
  def up
    add_column :todo_items, :complete, :boolean, default: false, null: false
  end

  def down
    remove_column :todo_items, :complete
  end
end
