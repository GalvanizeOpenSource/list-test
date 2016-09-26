require 'spec_helper'

describe "Deleting todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  def delete_todo_item(item)
    within("#todo_item_#{item.id}") do
      click_link("Delete")
    end
    within("#delete-confirm") do
      click_link("Yes, delete it!")
    end
  end

  it "deletes the selected item when there are multiple items", js: true do
    deleted_item = todo_list.todo_items.create(content: "Pizza")
    second_item = todo_list.todo_items.create(content: "Milk")

    visit_todo_list(todo_list)
    delete_todo_item(deleted_item)

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Your todo item was successfully removed."
  end

  it "deletes the item and the list when there is only one item", js: true do
    deleted_item = todo_list.todo_items.create(content: "Pizza")

    visit_todo_list(todo_list)
    delete_todo_item(deleted_item)

    expect(current_path).to eq(root_path)
    expect(page).to have_content "The last todo item was successfully removed and your todo list was deleted."
  end
end
