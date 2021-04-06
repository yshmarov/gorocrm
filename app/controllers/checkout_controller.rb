class CheckoutController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  
  def create
    @session = Stripe::Checkout::Session.create({
      customer: current_tenant.stripe_customer_id,
      success_url: checkout_success_url,
      cancel_url: checkout_failure_url,
      payment_method_types: ['card'],
      line_items: [
        {price: params[:price], quantity: 1},
      ],
      mode: 'subscription',
    })
    respond_to do |format|
      format.js
    end
  end

  def success
    redirect_to tenant_url(current_tenant), notice: "Subscribed successfully"
  end

  def failure
    redirect_to tenant_url(current_tenant), alert: "Cancelled"
  end
  
end