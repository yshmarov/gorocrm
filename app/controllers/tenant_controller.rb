class TenantController < ApplicationController
  #tenant-specific static pages
  include SetTenant #set ActsAsTenant.current_tenant
  include RequireTenant #no current_tenant = no access to entire controller
  include RequireActiveSubscription # no access unless tenant has an active subscription

  def dashboard
  end

  #example pages that can be here:
  #activity
  #charts and analytics

end
