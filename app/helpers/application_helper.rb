module ApplicationHelper
  include Pagy::Frontend

  def dark_mode_helper
    if cookies[:theme] == "light"
      link_to root_path(theme: "dark"), class: "btn btn-outline-secondary" do
        "<i class='fa fa-moon text-light'></i>".html_safe
      end
    else
      link_to root_path(theme: "light"), class: "btn btn-outline-secondary" do
        "<i class='far fa-moon text-light'></i>".html_safe
      end
    end
  end


  # boolean green or red
  def boolean_label(value)
    case value
      when true
        # content_tag(:span, "Yes", class: "badge bg-success")
        content_tag(:span, value, class: "badge bg-success")
      when false
        content_tag(:span, value, class: "badge bg-danger")
    end
  end

  # icons for omniauth
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

  def status_label(status)
    case status
    when "planned"
      content_tag(:span, status.titleize, class: "badge bg-danger")
    when "progress"
      content_tag(:span, status.titleize, class: "badge bg-warning")
    when "done"
      content_tag(:span, status.titleize, class: "badge bg-success")
    end
  end

  def social_color(provider)
    case provider
      when :google_oauth2
        "danger"
      when :github
        "dark"
      when :twitter
        "info"
      when :facebook
        "primary"
      when :gitlab
        "warning"
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

  # temporary solution while not using a gem like money. for superadmin dashboard
  def integer_to_currency(amount)
    "%.2f" % Rational(amount.to_i, 100)
  end

  # activity feed
  def crud_label(key)
    case key
      when "create"
        "<i class='fa fa-plus'></i>".html_safe
      when "update"
        "<i class='fa fa-pen'></i>".html_safe
      when "destroy"
        "<i class='fa fa-trash'></i>".html_safe
    end
  end

  # activity feed
  def model_label(model)
    case model
      when "Client"
        "<i class='fa fa-address-book'></i>".html_safe
      when "Project"
        "<i class='fa fa-tasks'></i>".html_safe
      when "Task"
        "<i class='fa fa-check-square'></i>".html_safe
      when "Payment"
        "<i class='fa fa-money-bill'></i>".html_safe
    end
  end

  def time_conversion(minutes)
    hours = minutes / 60
    rest = minutes % 60
    "#{hours}h #{rest}min"
  end

end
