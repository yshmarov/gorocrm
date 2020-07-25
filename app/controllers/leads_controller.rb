class LeadsController < ApplicationController

  skip_before_action :authenticate_user!
  layout  "leads_layout"

  before_action :set_tenant, only: [:new, :show]
  set_current_tenant_through_filter

  def new
  end
  
  def show
    @contact = Contact.find(params[:id])
    render 'contacts/show'
  end

  private
    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
      set_current_tenant(@tenant)
    end

end