class StaticPublicController < ApplicationController
  # no login required to see this controller
  skip_before_action :authenticate_user!

  def landing_page
  end

  def pricing
    @pricing = Stripe::Price.list(lookup_keys: ["good_year", "good_month"], expand: ["data.product"]).data.sort_by {|p| p.unit_amount}
  end

  def privacy
  end

  def terms
  end
end
