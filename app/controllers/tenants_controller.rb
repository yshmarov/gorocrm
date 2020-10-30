class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :switch]
  before_action :require_tenant_admin, only: [:edit, :update, :destroy]
  before_action :require_tenant_member, only: [:show]

  #before_action :require_superadmin, only: [:index]

  def index
    @tenants = Tenant.includes(:members, :users, members: [:user])
  end

  def switch
    if current_user.tenants.include?(@tenant)
      current_user.update_attribute(:tenant_id, @tenant.id)
      #redirect_to my_tenants_path, notice: "Switched to tenant: #{current_user.tenant.name}"
      redirect_to tenant_path(current_user.tenant), notice: t(".notice", tenant: current_user.tenant.name)
    else
      redirect_to my_tenants_path, alert: t(".alert", tenant: @tenant.name)
    end
  end

  def my
    @tenants = current_user.tenants
    render 'index'
  end

  set_current_tenant_through_filter
  def show
    set_current_tenant(@tenant)
    @charges = @tenant.charges
  end

  def new
    @tenant = Tenant.new
  end

  def edit
  end

  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      @member = Member.create!(tenant: @tenant, user: current_user, admin: true) #when a tenant is created, the creator becomes a member
      current_user.update_attribute(:tenant_id, @tenant.id) #when a tenant is created, the creator sets it as current_tenant
      redirect_to @tenant, notice: t(".notice")
    else
      render :new
    end
  end

  def update
    if @tenant.update(tenant_params)
      redirect_to @tenant, notice: t(".notice")
    else
      render :edit
    end
  end

  def destroy
    if @tenant.destroy
      redirect_to my_tenants_url, notice: t(".notice")
    else
      redirect_to my_tenants_url, alert: "Tenant has charges. Can not be destroyed."
    end
  end

  private
    def set_tenant
      @tenant = Tenant.friendly.find(params[:id])
    end

    def tenant_params
      params.require(:tenant).permit(:name, :plan, :logo)
    end

    def require_tenant_admin
      unless current_user.tenants.include?(@tenant) &&
        Member.find_by(user: current_user, tenant: @tenant).admin?
        redirect_to my_tenants_path, alert: t("tenants.require_tenant_admin.alert")
      end
    end

    def require_tenant_member
      unless current_user.tenants.include?(@tenant)
        redirect_to my_tenants_path, alert: t("tenants.require_tenant_member.alert")
      end
    end

    #def require_superadmin
    #  unless current_user.superadmin?
    #    redirect_to root_path, alert: "Only superadmins can see all tenants"
    #  end
    #end

end
