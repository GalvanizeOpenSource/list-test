require 'spec_helper'

describe 'TodoItems', type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:todo_list) { TodoList.create(title: 'some title', description: 'some description') }

  describe 'POST /api/todo_items/' do
    context 'with valid params' do
      it 'creates a todo item for a todo list' do
        params = { todo_list_id: todo_list.id, content: "this is some fun content" }

        post api_todo_items_path, params, headers: headers

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        expect(body['message']).to eq 'Saved todo list item.'
        expect(body['todo_item']['content']).to eq 'this is some fun content'
      end
    end

    context 'with invalid params' do
      it 'creates returns a todos errors' do
        params = { todo_list_id: todo_list.id, content: '' }

        post api_todo_items_path, params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body);

        expect(body['errors']).to include "Content can't be blank"
        expect(body['errors']).to include "Content is too short (minimum is 2 characters)"
      end
    end

    context 'with no todo list' do
      it 'returns an error message' do
        params = { todo_list_id: 300, content: 'some cool content' }

        post api_todo_items_path, params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body)
        expect(body['errors']).to include "Unable to find todo list to add item to."
      end
    end
  end
end
