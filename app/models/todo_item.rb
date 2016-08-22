# == Schema Information
#
# Table name: todo_items
#
#  id           :integer          not null, primary key
#  todo_list_id :integer
#  content      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  due_datetime :datetime
#  complete     :boolean          default(FALSE)
#

class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  validates :content, presence: true,
                      length: { minimum: 2 }
end
