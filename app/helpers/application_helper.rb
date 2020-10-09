module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

  def boolean_label(value)
    case value
      when true
        #content_tag(:span, "Yes", class: "badge badge-success")
        content_tag(:span, value, class: "badge badge-success")
      when false
        content_tag(:span, value, class: "badge badge-danger")
    end
  end

end
