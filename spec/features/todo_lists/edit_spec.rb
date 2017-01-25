require 'spec_helper'

describe "Editing todo lists" do
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery List") }
  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list."
    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "updates a todo list successfully with the correct information" do
    update_todo_list  todo_list: todo_list,
                      title: "New title",
                      description: "New description"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully created. Todo list was successfully created. Title: New title Description: New description Edit | Back")
    expect(todo_list.title).to eq("Groceries")
    expect(todo_list.description).to eq("Grocery List")
  end

  it "allows a user to add a new item to a todo list from index page" do

    visit "/todo_lists"

    within "#todo_list_#{todo_list.id}" do
      find('.add-item', text: 'Add item').click
    end

    expect(page).to have_content("Add a new todo item!")

    #TODO: save the new item
  end
end
