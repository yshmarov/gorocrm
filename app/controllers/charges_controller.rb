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

    respond_to do |format|
      if @charge.save
        @subscription = current_user.tenant.subscription
        @subscription.update(ends_at: @subscription.ends_at + @subscription.plan.interval_period)

        format.html { redirect_to current_user.tenant, notice: 'Charged successfully. Subscription updated.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_charge
      @charge = Charge.find(params[:id])
    end
end
