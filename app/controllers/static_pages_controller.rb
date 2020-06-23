class StaticPagesController < ApplicationController
  #no login required to see this controller
  #skip_before_action :authenticate_user!, :only => [:index]
  skip_before_action :authenticate_user!

  def index
  end

  #example pages that can be here:
  #about
  #terms_of_service
  #privacy_policy

end
