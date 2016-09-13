class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates_datetime :due_by, on_or_after: -> { DateTime.current },
                              allow_nil: true,
                              allow_blank: true

  scope :order_alphabetically, -> { where("due_by IS NULL OR due_by IS ''").order(content: :desc) }
  scope :order_due_by, ->         { where("due_by IS NOT NULL OR due_by <> ''").order(due_by: :asc) }
end
