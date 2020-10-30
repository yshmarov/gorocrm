class TenantController < ApplicationController
  include SetTenant #include ON TOP of controller that has to be scoped
  include RequireTenant #no current_tenant = no access to entire controller. redirect to root
  include RequireActiveSubscription # no access unless tenant has an active subscription

  #tenant-specific static pages

  def dashboard
  end

  #example pages that can be here:
  #activity
  #charts and analytics

end
