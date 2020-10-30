class SubscriptionsController < ApplicationController
  include SetTenant #include ON TOP of controller that has to be scoped
  include RequireTenant #no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember #for role-based authorization. @current_member.admin?

  before_action :set_subscription, only: [:destroy]

  before_action :require_tenant_admin

  def create
    plan = Plan.find(params[:plan])
    if current_tenant.members.count > plan.max_members
      redirect_to pricing_path, alert: "You feature comsumption exceeds this plan. Please select a bigger plan."
    else
      @subscription = Subscription.create(plan: plan, ends_at: Time.now)

      if @subscription.save
        redirect_to current_user.tenant, notice: 'Subscription was successfully created.'
      elsif current_user.tenant.subscription.present?
        redirect_to pricing_path, alert: "You already have a subscription."
      else
        redirect_to pricing_path, alert: "Something went wrong."
      end

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