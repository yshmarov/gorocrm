class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :switch]

  before_action :require_admin, only: [:edit, :update, :destroy]
  def require_admin
    if current_user.tenants.include?(@tenant) &&
      Member.find_by(user: current_user, tenant: @tenant).admin?
      #Member.find_by(user: current_user, tenant: @tenant).present? = current_user.tenants.include?(@tenant)
      # success
    else
      redirect_to tenants_path, alert: "You are not authorized"
    end
  end

  before_action :require_member, only: [:show]
  def require_member
    if current_user.tenants.include?(@tenant)
      # success
    else
      redirect_to tenants_path, alert: "You are not authorized"
    end
  end

  def index
    @tenants = Tenant.includes(:members, :users, members: [:user])
  end

  def switch
    if current_user.tenants.include?(@tenant)
      current_user.update_attribute(:tenant_id, @tenant.id)
      redirect_to my_tenants_path, notice: "Switched to tenant: #{current_user.tenant.name}"
      #redirect_to tenant_path(current_user.tenant), notice: "Switched to tenant: #{current_user.tenant.name}"
    else
      redirect_to my_tenants_path, alert: "You are not authorized to access tenant: #{@tenant.name}"
    end
  end

  def my
    @tenants = current_user.tenants
    render 'index'
  end

  set_current_tenant_through_filter
  def show
    set_current_tenant(@tenant)
  end

  def new
    @tenant = Tenant.new
  end

  def edit
  end

  def create
    @tenant = Tenant.new(tenant_params)

    respond_to do |format|
      if @tenant.save
        @member = Member.create!(tenant: @tenant, user: current_user, admin: true) #when a tenant is created, the creator becomes a member
        current_user.update_attribute(:tenant_id, @tenant.id) #when a tenant is created, the creator sets it as current_tenant
        format.html { redirect_to @tenant, notice: 'Tenant was successfully created.' }
        format.json { render :show, status: :created, location: @tenant }
      else
        format.html { render :new }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: 'Tenant was successfully updated.' }
        format.json { render :show, status: :ok, location: @tenant }
      else
        format.html { render :edit }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tenant.destroy
    respond_to do |format|
      format.html { redirect_to my_tenants_url, notice: 'Tenant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_tenant
      @tenant = Tenant.friendly.find(params[:id])
    end

    def tenant_params
      params.require(:tenant).permit(:name, :plan)
    end
end
