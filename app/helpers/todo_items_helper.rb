module TodoItemsHelper
  def link_to_toggle_todo_item_state(todo_item, modal = false)
    return 'Done!' if todo_item.complete?

    data = {
      'owner-id': todo_item.todo_list_id,
      url: api_todo_item_state_path(todo_item)
    }

    data.merge({ modal: true }) if modal
    button_text = modal == true ? 'Done' : 'Mark as done'

    link_to '#', class: 'toggle-state', data: data do
      button_text
    end
  end

  def completed_css_class(completed = false)
    return '' if completed == false

    'completed'
  end
end
