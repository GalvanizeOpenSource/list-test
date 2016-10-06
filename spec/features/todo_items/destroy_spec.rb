require 'spec_helper'

describe "Deleting todo lists" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}
  let!(:todo_item_1) { todo_list.todo_items.create(content: "Milk") }
  let!(:todo_item_2) { todo_list.todo_items.create(content: "Eggs") }

  it "is successful when clicking the destroy link" do
    visit "/todo_lists/#{todo_list.id}/todo_items"
    within "#todo_item_#{todo_item_1.id}" do
      click_link "Delete"
    end

    expect(page).to have_content("Your todo item was successfully removed.")
    expect(TodoItem.count).to be(1)

    visit "/todo_lists/#{todo_list.id}/todo_items"
    expect(page).to_not have_content(todo_item_1.content)

    within "#todo_item_#{todo_item_1.id}" do
      click_link "Delete"
    end

    expect(page).to have_content("The last todo item was successfully removed and your todo list was deleted.")
    expect(TodoItem.count).to be(1)
    expect(TodoList.count).to be(0)
  end
end
