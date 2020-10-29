class ChargesController < ApplicationController
  before_action :set_charge, only: [:show]

  #superadmin
  def index
    @charges = Charge.all
  end

  #invoice
  def show
  end

  def create
    @charge = Charge.create(
      tenant: current_user.tenant,
      subscription: current_user.tenant.subscription,
      amount: current_user.tenant.subscription.plan.amount
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
