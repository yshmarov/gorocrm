class BillingPortalController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root

  def create  
    portal_session = Stripe::BillingPortal::Session.create({
      customer: current_tenant.stripe_customer_id,
      return_url: tenant_url(current_tenant),
    })
    redirect_to portal_session.url
  end

end