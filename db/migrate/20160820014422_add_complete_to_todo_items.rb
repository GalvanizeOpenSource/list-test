class AddCompleteToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :complete, :boolean, default: false
  end
end
