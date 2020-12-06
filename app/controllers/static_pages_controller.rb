class StaticPagesController < ApplicationController
  # no login required to see this controller
  skip_before_action :authenticate_user!

  def landing_page
  end

  def about
  end

  def pricing
    @plans = Plan.all.order(amount: :asc)
  end

  def privacy
  end

  def terms
  end
end
