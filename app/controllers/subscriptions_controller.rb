class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]

  include SetTenant #set ActsAsTenant.current_tenant
  #include RequireTenant #no current_tenant = no access to entire controller
  include SetCurrentMember #for role-based authorization

  before_action :require_tenant_admin

  def create
    plan = Plan.find(params[:plan])
    @subscription = Subscription.create(plan: plan, ends_at: Time.now)

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

    def require_tenant_admin
      unless @current_member.admin?
        redirect_to tenant_path(current_tenant), alert: "You are not authorized to manage subscriptions"
      end
    end

end