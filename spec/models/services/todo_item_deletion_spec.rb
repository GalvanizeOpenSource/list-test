require 'spec_helper'

module Services
  describe TodoItemDeletion do
    let(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }

    describe '#perform' do
      describe 'when the todo_list has multiple todo_items' do
        let(:deleted_item) { todo_list.todo_items.create(content: "Pizza") }
        let!(:second_item) { todo_list.todo_items.create(content: "Milk") }
        subject { described_class.new(todo_list, deleted_item) }

        describe 'when successful' do
          before do
            expect(subject.perform).to be_truthy
          end

          it 'deletes the specified todo_item' do
            todo_list.reload
            expect(todo_list.todo_items).not_to include(deleted_item)
            expect(todo_list.todo_items).to include(second_item)
          end

          it 'returns the correct success message' do
            expect(subject.success_message).to eq("Your todo item was successfully removed.")
          end
        end

        describe 'when unsuccessful' do
          it 'returns false' do
            allow(deleted_item).to receive(:destroy).and_return(false)
            expect(subject.perform).to be_falsey
          end
        end
      end

      describe 'when the todo_list has only one todo_item' do
        let(:todo_item) { todo_list.todo_items.create(content: "Pizza") }
        subject { described_class.new(todo_list, todo_item) }

        describe 'when successful' do
          before do
            expect(subject.perform).to be_truthy
          end

          it 'deletes the entire todo_list and the todo_item' do
            expect(todo_list).not_to be_persisted
            expect(todo_item).not_to be_persisted
          end

          it 'returns the correct success message' do
            expect(subject.success_message)
              .to eq("The last todo item was successfully removed and your todo list was deleted.")
          end
        end

        describe 'when unseccessful' do
          it 'returns false' do
            allow(todo_list).to receive(:destroy).and_return(false)
            expect(subject.perform).to be_falsey
          end
        end
      end
    end
  end
end
