require 'spec_helper'

describe TodoListsController do
  let(:valid_attributes) { { "title" => "MyString" , "description" => "My description"} }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all todo_lists as @todo_lists" do
      todo_list = TodoList.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:todo_lists)).to eq [todo_list]
    end
  end

  describe "GET show" do
    it "assigns the requested todo_list as @todo_list" do
      todo_list = TodoList.create! valid_attributes
      get :show, {:id => todo_list.to_param}, valid_session
      expect(assigns(:todo_list)).to eq todo_list
    end
  end

  describe "GET new" do
    it "assigns a new todo_list as @todo_list" do
      get :new, {}, valid_session
      expect(assigns(:todo_list)).to be_a_new(TodoList)
    end
  end

  describe "GET edit" do
    it "assigns the requested todo_list as @todo_list" do
      todo_list = TodoList.create! valid_attributes
      get :edit, {:id => todo_list.to_param}, valid_session
      expect(assigns(:todo_list)).to eq todo_list
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TodoList" do
        expect {
          post :create, {:todo_list => valid_attributes}, valid_session
        }.to change(TodoList, :count).by(1)
      end

      it "assigns a newly created todo_list as @todo_list" do
        post :create, {:todo_list => valid_attributes}, valid_session
        expect(assigns(:todo_list)).to be_a TodoList
        expect(assigns(:todo_list)).to be_persisted
      end

      it "redirects to the created todo_list" do
        post :create, {:todo_list => valid_attributes}, valid_session
        expect(response).to redirect_to TodoList.last
      end
    end

    describe "with invalid params" do
      before do
        allow(TodoList).to receive(:save) { false }
      end

      it "assigns a newly created but unsaved todo_list as @todo_list" do
        post :create, {:todo_list => { "title" => "invalid value" }}, valid_session
        expect(assigns(:todo_list)).to be_a_new(TodoList)
      end

      it "re-renders the 'new' template" do
        post :create, {:todo_list => { "title" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before do
        allow(TodoList).to receive(:update).with({ "title" => "MyString" })
      end

      it "updates the requested todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested todo_list as @todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
        expect(assigns(:todo_list)).to eq todo_list
      end

      it "redirects to the todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
        expect(response).to redirect_to todo_list
      end
    end

    describe "with invalid params" do
      it "assigns the todo_list as @todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => { "title" => "invalid value" }}, valid_session
        expect(assigns(:todo_list)).to eq todo_list
      end

      it "re-renders the 'edit' template" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => { "title" => "" }}, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested todo_list" do
      todo_list = TodoList.create! valid_attributes
      expect {
        delete :destroy, {:id => todo_list.to_param}, valid_session
      }.to change(TodoList, :count).by(-1)
    end

    it "redirects to the todo_lists list" do
      todo_list = TodoList.create! valid_attributes
      delete :destroy, {:id => todo_list.to_param}, valid_session
      expect(response).to redirect_to todo_lists_url
    end
  end

end
