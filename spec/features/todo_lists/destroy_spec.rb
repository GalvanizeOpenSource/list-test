require 'spec_helper'

describe "Deleting todo lists" do
  it "is successful when clicking the destroy link", :js => true do
    todo_list = TodoList.create! title: "Groceries", description: "Grocery List"
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end

    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end
