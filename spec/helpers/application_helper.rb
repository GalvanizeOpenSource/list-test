require 'spec_helper'

describe ApplicationHelper, type: :helper do
  describe '#display_datetime_local' do
    context 'with datetime present' do
      let(:datetime) { DateTime.new(2016,9,14,0,0,0,'-8') }
      it 'returns a formatted datetime' do
        expect(display_datetime_local(datetime)).to eq "09/14/2016, 00:00"
      end
    end

    context 'with no datetime present' do
      it 'returns nil' do
        expect(display_datetime_local(nil)).to be_nil
      end
    end
  end

  describe '#display_error_messages' do
    let(:model) { TodoItem.create(content: '') }

    it 'returns html containing error messages' do
      expect(display_error_messages(model)).to include "<div id=\"error_explanation\"><ul><h2>2 errors prohibited this Todo item from being saved:</h2><li>Content can&#39;t be blank</li><li>Content is too short (minimum is 2 characters)</li></ul></div>"
    end
  end
end
