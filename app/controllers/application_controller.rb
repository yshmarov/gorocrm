class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include SetLocale
  include SetTimeZone
  include SetTheme

  include PublicActivity::StoreController # save current_user using gem public_activity

  include Pagy::Backend

  # devise
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
