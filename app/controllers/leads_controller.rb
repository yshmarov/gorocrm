class LeadsController < ApplicationController

  skip_before_action :authenticate_user!
  layout  "leads_layout"

  before_action :set_tenant, only: [:new, :show, :create]
  set_current_tenant_through_filter

  def new
    @contact = Contact.new
  end
  
  def show
    @contact = Contact.find(params[:id])
    render 'contacts/show'
  end
  
  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to tenant_lead_path(@tenant, @contact), notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
      set_current_tenant(@tenant)
    end

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :phone_number, :email)
    end

end