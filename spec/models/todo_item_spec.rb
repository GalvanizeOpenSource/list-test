# == Schema Information
#
# Table name: todo_items
#
#  id           :integer          not null, primary key
#  todo_list_id :integer
#  content      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe TodoItem do
 it { should belong_to(:todo_list) }
end
