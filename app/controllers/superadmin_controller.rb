class SuperadminController < ApplicationController
  def dashboard
  end

  def tenants
    @tenants = Tenant.includes(:members, :users, members: [:user])
    render "tenants/index"
  end

  def users
    @users = User.includes(:members, :tenants, members: [:tenant])
  end

  def charges
    @charges = Charge.all
  end

  def subscriptions
    @subscriptions = Subscription.all
  end
end
