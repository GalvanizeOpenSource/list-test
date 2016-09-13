require 'spec_helper'

describe TodoItem do
  it { should belong_to(:todo_list) }
  it { should respond_to(:content)  }
  it { should respond_to(:due_by)   }

  subject { described_class.create(args) }
  let(:args) { { } }

  describe '#content' do
    context 'with valid attributes' do
      let(:args) { { content: 'some_content' } }

      it 'should be a valid TodoItem' do
        expect(subject.valid?).to eq true
      end

      # TODO: Brittle test
      # shoulda_matchers are much more fitting
      it 'should be present' do
        expect(subject.errors.full_messages).to be_empty
      end

      it 'should have a length of 2' do
        expect(subject.errors.full_messages).to be_empty
      end
    end

    context 'with invalid attributes' do
      let(:args) { { content: '' } }

      it 'should have a presence validation error' do
        expect(subject.errors.full_messages[0]).to include "can't be blank"
      end

      it 'should have a length validation error' do
        expect(subject.errors.full_messages[1]).to include "is too short (minimum is 2 characters)"
      end
    end
  end

  describe '#due_by' do
    context 'with a valid due_by datetime' do
      let(:valid_date) { DateTime.current + 1.minute }
      let(:args) { { content: SecureRandom.hex, due_by: valid_date } }

      it 'should be a valid datetime' do
        expect(subject.errors.messages).to be_empty
      end
    end

    context 'with a due_by datetime in the past' do
      let(:invalid_date) { DateTime.current - 1.minute }
      let(:args) { { content: SecureRandom.hex, due_by: invalid_date } }

      it 'throws a validation error' do
        expect(subject.errors.messages).to_not be_empty
      end

      it 'has the due by key' do
        expect(subject.errors.full_messages[0]).to include("Due by must be on or after")
      end
    end
  end

  describe '.order_alphabetically' do
    let(:todo_item_1) { described_class.create(content: 'anteater') }
    let(:todo_item_2) { described_class.create(content: 'beaver')   }

    let(:todo_item_3) { described_class.create(content: 'coyote', due_by: DateTime.current + 1.minute) }

    it 'orders blank due_by todo_items alphabetically ascending (z - a)' do
      expect(described_class.order_alphabetically).to eq [todo_item_2, todo_item_1]
    end

    it 'excludes todo_items with a due_by date set' do
      expect(described_class.order_alphabetically).to_not include todo_item_3
    end
  end

  describe '.order_due_by' do
    let(:todo_item_1) { described_class.create(content: 'zebra', due_by: DateTime.current + 2.minutes) }
    let(:todo_item_2) { described_class.create(content: 'lion', due_by: DateTime.current + 1.minute)   }

    let(:todo_item_3) { described_class.create(content: 'chimpanzee') }

    it 'orders due_by column in order (oldest - newest)' do
      expect(described_class.order_due_by).to eq [todo_item_2, todo_item_1]
    end

    it 'excludes todo_items without due_by datetime set' do
      expect(described_class.order_due_by).to_not include todo_item_3
    end
  end

  describe '#completed?' do
    context 'when complete' do
      let(:args) { { content: 'lion', complete: true } }

      it 'aliases complete boolean method' do
        expect(subject.completed?).to eq true
      end
    end

    context 'when incomplete' do
      let(:args) { { content: 'lion', complete: false } }

      it 'aliases complete boolean method' do
        expect(subject.completed?).to eq false
      end
    end
  end

  describe '.due_in' do
    let(:todo_item_1) { described_class.create(content: 'zebra', due_by: DateTime.current + 2.minutes) }
    let(:todo_item_2) { described_class.create(content: 'lion', due_by: DateTime.current + 1.minute)   }

    let(:todo_item_3) { described_class.create(content: 'chimpanzee', due_by: DateTime.current + 3.minutes, complete: true) }

    it 'returns incomplete todo_items due within 10 minutes from the current datetime' do
      expect(described_class.due_in).to eq [todo_item_1, todo_item_2]
    end

    it 'does not return complete todo_items due within 10 minutes from the current datetime' do
      expect(described_class.due_in).to_not include todo_item_3
    end
  end

  describe '#toggle_state' do
    let(:args) { { complete: false, content: 'zebra' } }

    before do
      subject.toggle_state!
    end

    it 'toggles the state of an incomplete todo_item' do
      expect(subject.complete).to eq true
    end

    it 'does not raise validation errors when no due_by is set' do
      expect(subject.errors.full_messages).to be_empty
    end
  end
end
