class SuperadminController < ApplicationController
  def dashboard
  end

  def tenants
    @tenants = Tenant.includes(:members, :users, members: [:user]).order(created_at: :desc)
    render "tenants/index"
  end

  def users
    @users = User.includes(:members, :tenants, members: [:tenant]).order(created_at: :desc)
  end

  def charges
    @charges = Charge.all.order(created_at: :desc)
  end

  def subscriptions
    @subscriptions = Subscription.all.order(created_at: :desc)
  end
end
