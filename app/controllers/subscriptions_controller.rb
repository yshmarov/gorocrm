class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]

  def create
    plan = Plan.find(params[:plan])
    @subscription = Subscription.create(plan: plan, tenant: current_user.tenant, ends_at: Time.now)

    if @subscription.save
      redirect_to current_user.tenant, notice: 'Subscription was successfully created.'
    elsif current_user.tenant.subscription.present?
      redirect_to pricing_path, alert: "You already have a subscription."
    else
      redirect_to pricing_path, alert: "Something went wrong."
    end
  end

  def destroy
    @subscription.destroy
    redirect_to current_user.tenant, notice: 'Subscription was successfully destroyed.'
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

end