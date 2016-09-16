class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates_datetime :due_by, on_or_after: -> { DateTime.current },
                              allow_nil: true,
                              allow_blank: true

  scope :order_alphabetically, -> { where("due_by IS NULL OR due_by IS ''").order(content: :desc) }
  scope :order_due_by, ->         { where("due_by IS NOT NULL OR due_by <> ''").order(due_by: :asc) }

  def self.due_in(minutes = 10.minutes)
    end_datetime = DateTime.current + minutes
    where(complete: false, due_by: [DateTime.current..end_datetime])
  end

  # TODO: Look into alias_method, odd behavior with complete? method
  def completed?
    complete?
  end

  # NOTE: This method began its life toggling the state using !completed?
  # but due to the assignment not requiring "toggling" we only mark the todo_item complete
  # This method will allow us to implement toggle functionality with relative ease.
  def toggle_state!
    self.complete = true
    self.save(validate: false)
    self
    # NOTE: uncomment if you'd like to see an error message thrown when marking a todo item complete.
    # raise ActiveRecord::Rollback
  end
end
