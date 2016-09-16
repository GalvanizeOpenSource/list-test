class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # NOTE: Not my favorite hack, but will work for the time alloted.
  # Instead of rendering the collection via ajax/jquery,
  # we'll pass the due items as a helper to the modal partial.
  def due_todo_items
    @due_todo_items ||= TodoItem.due_in(10.minutes)
  end

  helper_method :due_todo_items
end
