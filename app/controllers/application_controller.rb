class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include SetLocale
  include SetTimeZone

  before_action :set_theme
  
  def set_theme
    if params[:theme].present?
      theme = params[:theme].to_sym
      if ["light", "dark"].include?(params[:theme])
        # session[:theme] = theme
        cookies[:theme] = theme
      else
        cookies[:theme] = "light"
      end
      redirect_to (request.referrer || root_path), notice: "The css for dark mode is still experimental"
    end
  end

  # devise
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
