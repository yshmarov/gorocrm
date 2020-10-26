class TenantController < ApplicationController
  #tenant-specific static pages
  include SetTenant #set ActsAsTenant.current_tenant
  include RequireTenant #no current_tenant = no access to entire controller

  def dashboard
  end

  #example pages that can be here:
  #activity
  #charts and analytics

end
