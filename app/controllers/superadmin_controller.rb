class SuperadminController < ApplicationController

  def dashboard
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