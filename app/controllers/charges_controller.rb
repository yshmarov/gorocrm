class ChargesController < ApplicationController
  before_action :set_charge, only: [:show]

  #invoice
  def show
  end

  def create
    @subscription = current_user.tenant.subscription
    @plan = @subscription.plan

    @charge = Charge.create(
      tenant: current_user.tenant,
      subscription: @subscription,
      period_start: @subscription.ends_at,
      period_end: @subscription.ends_at + @subscription.plan.interval_period,
      plan_name: @plan.name,
      plan_amount: @plan.amount,
      plan_currency: @plan.currency,
      plan_interval: @plan.interval,
      plan_conditions: @plan.max_members
      )

    if @charge.save
      @subscription = current_user.tenant.subscription
      @subscription.update(ends_at: @subscription.ends_at + @subscription.plan.interval_period)

      redirect_to current_user.tenant, notice: 'Charged successfully. Subscription updated.'
    else
      render :new
    end

  end

  private
    def set_charge
      @charge = Charge.find(params[:id])
    end
end
