module TodoItemsHelper
  def ordered(todo_items)
  	has_due_date = todo_items.has_due_date.sort_by{ |todo_item| todo_item.due_date }.reverse
  	nil_due_date = todo_items.nil_due_date.sort_by{ |todo_item| todo_item.content  }.reverse

  	has_due_date + nil_due_date
  end
end
