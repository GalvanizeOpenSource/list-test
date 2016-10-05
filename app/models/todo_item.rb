class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  attr_accessor :timezone_offset
  attr_accessor :due_date_valid

  before_save :adjust_timezone

  validates :content, presence: true,
                      length: { minimum: 2 }

  validate :validate_due_date

  def self.pending
  	where(done: false)
  end

  def self.has_due_date
  	where.not(due_date: nil)
  end

  def self.nil_due_date
  	where(due_date: nil)
  end

  def adjust_timezone
  	return if self.due_date.blank?
  	return unless due_date_changed?

  	self.due_date = self.due_date.to_formatted_s(:long) + timezone_offset
  end

  def validate_due_date
  	if !due_date_valid
  	  errors.add(:due_date, "must be blank or in the format 'yyyy/mm/dd HH24:MM'")
  	end
  end
end
