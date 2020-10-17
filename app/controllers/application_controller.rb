class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  #include SetTenant #set ActsAsTenant.current_tenant

  before_action :set_locale
  
  private
  
  def set_locale
    if params['locale'].present?
      language = params['locale'].to_sym
      session['locale'] = language
      if user_signed_in?
        current_user.update(language: language)
      end
      redirect_to root_path
    elsif session['locale'].present?
      language = session['locale']
    else
      language = I18n.default_locale
    end
    
    if user_signed_in? && current_user.language.present?
      language = current_user.language
    end

    if I18n.available_locales.map(&:to_s).include?(language)
      I18n.locale = language
    else
      I18n.locale = I18n.default_locale
    end
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

end
