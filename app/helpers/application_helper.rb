module ApplicationHelper
  def display_datetime_local(datetime)
    datetime.strftime("%m/%d/%Y, %H:%M") if datetime.present?
  end

  def display_error_messages(model)
    if model.errors.any?
      message = " prohibited this #{model.class.to_s.underscore.humanize} from being saved:"
      error_title = pluralize(model.errors.count, 'error')
      content = ""
      content += content_tag(:h2, error_title.concat(message))

      list_items = model.errors.full_messages.each do |message|
        content += content_tag(:li, message)
      end

      content_tag(:div, '', id: 'error_explanation') do
        content_tag(:ul) do
          content.html_safe
        end
      end
    end
  end
end
