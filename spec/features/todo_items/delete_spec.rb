require 'spec_helper'

describe "Deleting todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}
  let!(:todo_item1) { todo_list.todo_items.create(content: "Milk") }
  # let!(:todo_item2) { todo_list.todo_items.create(content: "Eggs") }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it "is successful deleting only remaining item" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item1.id}") do
      click_link "Delete"
    end
    expect(page).to have_content("The last todo item was successfully removed and your todo list was deleted")
  end

  it "is successful deleting an item" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Eggs"
    click_button "Save"
    within("#todo_item_#{todo_item1.id}") do
      click_link "Delete"
    end
    expect(page).to have_content("Your todo item was successfully removed")
  end
end
