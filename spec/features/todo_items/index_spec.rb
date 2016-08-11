require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
    click_link "List Items"
  end

  end
  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within('h1') do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "displays no items when a todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items li").size).to eq(0)
  end

  it "displays item content when a todo list has items" do
    todo_list.todo_items.create(content: "Milk")
    todo_list.todo_items.create(content: "Eggs")

    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items li").size).to eq(2)

    within('ul.todo_items') do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Eggs")
    end
  end

  it "displays delete link" do
    todo_list.todo_items.create(content: "Milk")
    todo_list.todo_items.create(content: "Eggs")

    visit_todo_list(todo_list)

    within('ul.todo_items') do
      expect(page).to have_content("Delete Todo Item")
    end
  end

  # it " displays a confirmation modal when delete link is clicked" do
  #   todo_list.todo_items.create(content: "Milk")
  #   todo_list.todo_items.create(content: "Eggs")
  #
  #   visit_todo_list(todo_list)
  #
  #   within('ul.todo_items') do
  #     first(:link, "Delete Todo Item").click
  #     page.accept_confirm do
  #         page.should have_content("Is it OK to delete this todo list item?")
  #     end
  #   end
  # end

  # it "redirects to tod0_item index page theres an error" do
  # end
end
