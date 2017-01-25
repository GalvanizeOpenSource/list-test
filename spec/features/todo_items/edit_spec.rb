require 'spec_helper'

describe "Editing todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk", due_date: "02/01/2017 13:00") }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it "is successful with valid content" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "Lots of Milk"
    click_button "Save"
    expect(page).to have_content("Saved todo list item.")
    todo_item.reload
    expect(todo_item.content).to eq("Lots of Milk")
  end

  it "is successful with valid due date" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Due date", with: "02/02/2017 12:00"
    click_button "Save"
    expect(page).to have_content("Saved todo list item.")
    todo_item.reload
    expect(todo_item.due_date).to eq(DateTime.parse("02/02/2017 12:00"))
  end

  it "is successful without a due date" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Due date", with: ""
    click_button "Save"
    expect(page).to have_content("Saved todo list item.")
    todo_item.reload
    expect(todo_item.due_date).to be nil
  end

  it "is unsuccessful with no content" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: ""
    click_button "Save"
    expect(page).to_not have_content("Saved todo list item.")
    expect(page).to have_content("Content can't be blank")
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end

  it "is unsuccessful with not enough content" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "1"
    click_button "Save"
    expect(page).to_not have_content("Saved todo list item.")
    expect(page).to have_content("Content is too short")
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end


end
