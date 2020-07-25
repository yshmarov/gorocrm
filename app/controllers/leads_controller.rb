class LeadsController < ApplicationController

  skip_before_action :authenticate_user!
  layout  "leads_layout"

  before_action :set_tenant, only: [:new]
  set_current_tenant_through_filter

  def new
    set_current_tenant(@tenant)
  end

  private
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

end