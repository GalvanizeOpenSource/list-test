require 'spec_helper'

describe "todo_lists/show" do
  before(:each) do
    @todo_list = assign(:todo_list, stub_model(TodoList,
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
