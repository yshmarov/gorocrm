module ApplicationHelper
  def bootstrap_class_for flash_type
    {success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info"}.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") {
               concat content_tag(:button, "x", class: "close", data: {dismiss: "alert"})
               concat message
             })
    end
    nil
  end

  def boolean_label(value)
    case value
      when true
        # content_tag(:span, "Yes", class: "badge badge-success")
        content_tag(:span, value, class: "badge badge-success")
      when false
        content_tag(:span, value, class: "badge badge-danger")
    end
  end

  def social_icon(provider)
    case provider
      when :google_oauth2
        content_tag(:i, nil, class: "fab fa-google")
      when :github
        content_tag(:i, nil, class: "fab fa-github")
      when :twitter
        content_tag(:i, nil, class: "fab fa-twitter")
      when :facebook
        content_tag(:i, nil, class: "fab fa-facebook")
      when :gitlab
        content_tag(:i, nil, class: "fab fa-gitlab")
    end
  end

  # link_to "homepage", root_path
  def active_link_to(name, path)
    content_tag(:li, class: "#{"active font-weight-bold" if current_page?(path)} nav-item") do
      link_to name, path, class: "nav-link"
    end
  end

  # link_to root_path do "homepage"
  def long_active_link_to(path)
    content_tag(:li, class: "#{"active font-weight-bold" if current_page?(path)} nav-item") do
      link_to path, class: "nav-link" do
        yield
      end
    end
  end

  # link_to root_path do "homepage"
  def sidebar_long_active_link_to(path)
    content_tag(:li, class: "#{"active font-weight-bold bg-light shadow rounded" if current_page?(path)} nav-item") do
      link_to path, class: "nav-link" do
        yield
      end
    end
  end
end
