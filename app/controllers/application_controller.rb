class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  #include SetTenant #set ActsAsTenant.current_tenant

  before_action :set_locale
  
  private
  
  def set_locale
    if params['locale'].present?
      language = params['locale'].to_sym
      session['locale'] = language
      redirect_to root_path
    elsif session['locale'].present?
      language = session['locale']
    else
      language = I18n.default_locale
    end

    if I18n.available_locales.map(&:to_s).include?(language)
      I18n.locale = language
    else
      I18n.locale = I18n.default_locale
    end
  end

end
