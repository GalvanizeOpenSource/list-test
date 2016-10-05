require 'spec_helper'

describe TodoItem do
 it { should belong_to(:todo_list) }

 it 'raises errors when due_date_valid is false' do
   todo_item = TodoItem.create(content: 'Test Todo', due_date_valid: false)
   expect(todo_item.errors.messages.keys.first).to eq(:due_date)
 end

 it 'saves when due_date_valid is true' do
   todo_item = TodoItem.create(content: 'Test Todo', due_date_valid: true)
   todo_item.reload
   expect(todo_item.new_record?).to eq(false)
 end
end
