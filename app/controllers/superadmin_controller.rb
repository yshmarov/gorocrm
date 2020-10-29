class SuperadminController < ApplicationController

  def dashboard
  end

  def charges
    @charges = Charge.all
  end

  def subscriptions
    @subscriptions = Subscription.all
  end

end