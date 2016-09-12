require 'spec_helper'

describe TodoItem do
  it { should belong_to(:todo_list) }

  describe '#due_by' do
    subject { described_class.create(args) }

    context 'with a valid due_by datetime' do
      let(:valid_date) { DateTime.current + 1.minute }
      let(:args) { { content: SecureRandom.hex, due_by: valid_date } }

      it 'should be a valid datetime' do
        expect(subject.errors.any?).to eq false
      end
    end

    context 'with a due_by datetime in the past' do
      let(:invalid_date) { DateTime.current - 1.minute }
      let(:args) { { content: SecureRandom.hex, due_by: invalid_date } }

      it 'throws a validation error' do
        expect(subject.errors.any?).to eq true
      end

      it 'has the due by key' do
        expect(subject.errors.full_messages[0]).to include("Due by must be on or after")
      end
    end
  end
end
