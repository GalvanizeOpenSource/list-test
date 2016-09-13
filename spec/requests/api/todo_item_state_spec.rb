require 'spec_helper'

describe 'TodoItemState', type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:todo_list) { TodoList.create(title: 'some title', description: 'some description') }
  let(:todo_item) { todo_list.todo_items.create(content: 'some content', due_by: DateTime.current + 1.minute) }

  describe 'PUT /api/todo_item_state' do
    context 'with a valid todo list' do
      it 'completes the todo item' do
        put api_todo_item_state_path(id: todo_item.id), { todo_list_id: todo_list.id }, headers: headers
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['todo_item']['complete']).to eq true
      end
    end

    context 'with no existing todo list or todo item' do
      it 'returns a json response with errors' do
        put api_todo_item_state_path(300), { todo_list_id: 300 }, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body);
        expect(body['error_text']).to eq 'Sorry, we could not mark your todo item as done'
      end
    end
  end
end
