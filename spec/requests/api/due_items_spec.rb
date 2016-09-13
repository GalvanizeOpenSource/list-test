require 'spec_helper'

describe 'DueItems', type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }

  describe 'GET /api/due_items' do
    context 'with due items' do
      it 'returns a list of due items' do
        args = { content: SecureRandom.hex(10), due_by: DateTime.current + 1.minute }

        item1 = TodoItem.create(args)
        item2 = TodoItem.create(args)

        get api_due_items_path, headers: headers

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['todo_items'].size).to eq 2
      end
    end

    context 'without due items' do
      it 'returns an empty list' do
        get api_due_items_path, headers: headers

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['todo_items']).to eq []
      end
    end
  end
end
