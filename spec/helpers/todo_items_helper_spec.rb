require 'spec_helper'

describe TodoItemsHelper, type: :helper do
  describe '#link_to_toggle_todo_item_state' do
    let(:todo_item) do
      TodoItem.create({ todo_list_id: 1, content: 'valid_content'}.merge(args))
    end

    context 'with an incomplete todo item' do
      let(:args) { { } }
      it 'returns link html' do
        expect(link_to_toggle_todo_item_state(todo_item)).to include "<a class=\"toggle-state\" data-owner-id=\"1\" data-url=\"/api/todo_item_state/1\" href=\"#\">Mark as done</a>"
      end
    end

    context 'with a complete todo item' do
      let(:args) { { complete: true } }

      it 'returns done message' do
        expect(link_to_toggle_todo_item_state(todo_item)).to eq "Done!"
      end
    end

    context 'with modal set to true' do
      let(:args) { { } }

      it 'returns done message without exclamation' do
        expect(link_to_toggle_todo_item_state(todo_item, true)).to include "<a class=\"toggle-state\" data-owner-id=\"1\" data-url=\"/api/todo_item_state/1\" href=\"#\">Done</a>"
      end
    end
  end

  describe '#completed_css_class' do
    context 'when incomplete' do
      it 'returns an empty string' do
        expect(completed_css_class(false)).to eq ''
      end
    end

    context 'when complete' do
      it 'returns completed' do
        expect(completed_css_class(true)).to eq 'completed'
      end
    end
  end
end
