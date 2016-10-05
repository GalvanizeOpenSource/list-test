require 'spec_helper'

describe "Updating todo items" do
  let!(:todo_list) { TodoList.create!(title: "Grocery list", description: "Groceries")}
  let!(:todo_item) { todo_list.todo_items.create!(content: "Milk", due_date_valid: true) }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it 'updates row when Done is clicked' do
  	visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Done"
    end

    expect(page).to have_content("Done!")
    todo_item.reload
    expect(todo_item.done).to eq(true)
  end
end