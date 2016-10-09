require 'spec_helper'

describe "Deleting todo items" do
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery List") }
  let!(:todo_item) { TodoItem.create(content: "Get milk and eggs") }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  # Not sure why this isn't working
  it "is successful when clicking the delete link" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}", :visible => false) do
      click_link "Destroy"
    end
    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end