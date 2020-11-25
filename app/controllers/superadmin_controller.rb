class SuperadminController < ApplicationController
  def dashboard
  end

  def tenants
    @tenants = Tenant.includes(:members, :users, :subscription, subscription: [:plan], members: [:user]).order(created_at: :desc)
    render "tenants/index"
  end

  def users
    @users = User.includes(:identities, :members, :tenants, members: [:tenant]).order(created_at: :desc)
  end

  def charges
    @charges = Charge.includes(:tenant).order(created_at: :desc)
  end

  def subscriptions
    @subscriptions = Subscription.includes(:tenant, :plan).order(created_at: :desc)
  end
end
