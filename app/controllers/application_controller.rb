class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  #include SetTenant #set ActsAsTenant.current_tenant

end
