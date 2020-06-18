class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  set_current_tenant_through_filter #acts_as_tenant
  before_action :set_tenant

  def set_tenant
    current_account = Tenant.second
    set_current_tenant(current_account)
  end

end
