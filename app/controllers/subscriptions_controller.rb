class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]

  #superadmin
  def index
    @subscriptions = Subscription.all
  end

  def create
    plan = Plan.find(params[:plan])
    @subscription = Subscription.create(plan: plan, tenant: current_user.tenant, ends_at: Time.now)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to current_user.tenant, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

end
