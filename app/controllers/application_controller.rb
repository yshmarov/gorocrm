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
      language = 'en'
    end
    
    I18n.locale = language
  end

end
