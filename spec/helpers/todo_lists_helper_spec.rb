require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the TodoListsHelper. For example:
#
# describe TodoListsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe TodoListsHelper do
  let(:todo_item) { TodoItem.create(content: "Only one item") }
  let(:todo_list) { TodoList.create(title: "Delete This List", description: "This list should be deleted after deleting items") }

  before() do
    todo_list.todo_items << todo_item
  end

  it "destroy method will delete an item" do
    expect { todo_item.destroy }.to change { TodoItem.count }.by(-1) 
  end
  
end


