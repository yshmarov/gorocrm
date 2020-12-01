class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include SetLocale
  include SetTimeZone
  include SetTheme

  # devise
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
