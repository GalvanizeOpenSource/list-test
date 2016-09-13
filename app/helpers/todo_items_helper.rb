module TodoItemsHelper
  def link_to_toggle_todo_item_state(todo_item)
    return 'Done' if todo_item.complete?

    data = {
      'owner-id': todo_item.todo_list_id,
      url: api_todo_item_state_path(todo_item)
    }

    link_to '#', class: 'toggle-state', data: data do
      "Mark as done"
    end
  end

  def completed_css_class(completed = false)
    return '' if completed == false

    'completed'
  end
end
