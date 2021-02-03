module ApplicationHelper

  def dark_mode_helper
    if cookies[:theme] == "light"
      link_to root_path(theme: "dark"), class: "btn btn-sm btn-outline-secondary" do
        "<i class='fa fa-moon text-light'></i>".html_safe
      end
    else
      link_to root_path(theme: "light"), class: "btn btn-sm btn-outline-secondary" do
        "<i class='far fa-moon text-light'></i>".html_safe
      end
    end
  end


  # boolean green or red
  def boolean_label(value)
    case value
      when true
        # content_tag(:span, "Yes", class: "badge badge-success")
        content_tag(:span, value, class: "badge badge-success")
      when false
        content_tag(:span, value, class: "badge badge-danger")
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
      content_tag(:span, status.titleize, class: "badge badge-danger")
    when "progress"
      content_tag(:span, status.titleize, class: "badge badge-warning")
    when "done"
      content_tag(:span, status.titleize, class: "badge badge-success")
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

  # logic to subscribe to a specific plan
  def subscribe_to(plan)
    if user_signed_in?
      if current_user.tenant.present?
        if current_user.tenant.subscription.present?
          t(".you_already_are_subscribed")
        elsif Member.find_by(user: current_user, tenant: current_user.tenant).admin?
          button_to "#{t(".subscribe").capitalize}: #{plan.name}", subscriptions_path(plan: plan), method: :post
        else
          t(".contact_admin_to_subscribe", tenant: current_user.tenant)
        end
      else
        t(".create_a_tenant_to_select_plan")
      end
    else
      link_to t("header.register"), new_user_registration_path, class: "btn btn-xl btn-success"
    end
  end
end
