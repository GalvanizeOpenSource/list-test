class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates_datetime :due_by, on_or_after: -> { DateTime.current }
end
