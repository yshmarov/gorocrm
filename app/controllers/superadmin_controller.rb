class SuperadminController < ApplicationController
  def dashboard
    @total_earnings = Charge.all.pluck(:metadata).inject(0) { |sum, h| sum + h[:plan_amount] }
    @l12m_earnings = Charge.where(created_at: Time.now - 12.months..Time.now).pluck(:metadata).inject(0) { |sum, h| sum + h[:plan_amount] }
    @current_month_earnings = Charge.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).pluck(:metadata).inject(0) { |sum, h| sum + h[:plan_amount] }
    @last_month_earnings = Charge.where(created_at: Time.now.last_month.beginning_of_month..Time.now.last_month.end_of_month ).pluck(:metadata).inject(0) { |sum, h| sum + h[:plan_amount] }
  end

  def tenants
    @q = Tenant.order(created_at: :desc).ransack(params[:q])
    @tenants = @q.result.includes(:members, :users, :subscription, subscription: [:plan], members: [:user])
    # @tenants = Tenant.includes(:members, :users, :subscription, subscription: [:plan], members: [:user]).order(created_at: :desc)
    render "tenants/index"
  end

  def users
    @q = User.order(created_at: :desc).ransack(params[:q])
    @users = @q.result.includes(:identities, :members, :tenants, members: [:tenant])
    # @users = User.includes(:identities, :members, :tenants, members: [:tenant]).order(created_at: :desc)
  end

  def charges
    @charges = Charge.includes(:tenant).order(created_at: :desc)
  end

  def subscriptions
    @subscriptions = Subscription.includes(:tenant, :plan).order(created_at: :desc)
  end
end
