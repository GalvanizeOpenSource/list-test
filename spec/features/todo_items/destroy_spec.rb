require 'spec_helper'

describe "Deleting todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it "is successful when clicking the destroy link" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Destroy"
    end
    expect(page).to_not have_content(todo_list.title)
    expect(TodoItem.count).to eq(0)
  end
end