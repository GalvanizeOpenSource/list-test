require 'spec_helper'

describe TodoItemsController, type: :controller do
  before do
    @todo_list = TodoList.create(title: "My Title", description: "This is my test list")
    @todo_item = @todo_list.todo_items.create(content: "Get milk and eggs")
  end

  describe '#index' do
    it 'should set the @todo_list controller based off the todo_list_id' do
      get :index, todo_list_id: @todo_list.id

      expect(assigns(:todo_list)).to eq(@todo_list)
    end

    it 'should redirect to new_todo_list_path if todo_list is not found' do
      get :index, todo_list_id: '3030303'
      expect(response).to redirect_to(new_todo_list_path)
    end

    it 'should render the index template' do
      get :index, todo_list_id: @todo_list.id
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it 'should render the new template' do
      get :new, todo_list_id: @todo_list.id
      expect(response).to render_template(:new)
    end

    it 'should redirect to new_todo_list_path if todo_list is not found' do
      get :new, todo_list_id: @todo_list.id + 1
      expect(response).to redirect_to(new_todo_list_path)
    end
  end

  describe "#edit" do
    it 'should render the edit template' do
      get :edit, todo_list_id: @todo_list.id, id: @todo_item.id
      expect(response).to render_template(:edit)
    end

    it 'should redirect to new_todo_list_path if todo_list is not found' do
      get :edit, todo_list_id: @todo_list.id + 1, id: @todo_item.id
      expect(response).to redirect_to(new_todo_list_path)
    end
  end

  describe "#update" do
    it 'should redirect to the index' do
      put :update, todo_list_id: @todo_list.id, id: @todo_item.id, todo_item: {content: @todo_item.content}
      expect(response).to redirect_to(todo_list_todo_items_path)
    end

    it 'should redirect to new_todo_list_path if todo_list is not found' do
      put :update, todo_list_id: @todo_list.id + 1, id: @todo_item.id
      expect(response).to redirect_to(new_todo_list_path)
    end

    it 'should update the specified item' do
      put :update, todo_list_id: @todo_list.id, id: @todo_item.id, todo_item: {content: "New content"}
      expect(@todo_item.reload.content).to eq "New content"
    end
  end

  describe "#create" do
    it 'should create a new todo item for the specified list' do
      post :create, todo_list_id: @todo_list.id, todo_item: { content: "This is my new item" }
      expect(@todo_list.todo_items.length).to eq(2)
      expect(@todo_list.todo_items[1].content).to eq("This is my new item")
    end

    it 'should redirect to new_todo_list_path if todo_list is not found' do
      post :create, todo_list_id: @todo_list.id + 1, todo_item: { content: "This is my new item" }
      expect(response).to redirect_to(new_todo_list_path)
    end
  end
end
