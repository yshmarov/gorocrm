class TenantController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember # for role-based authorization. @current_member.admin?
  include RequireActiveSubscription # no access unless tenant has an active subscription

  # tenant-scoped static pages

  def dashboard
  end

  def calendar
    @members = Member.all.order(id: :asc)
    
    if params.has_key?(:member_id)
      tasks = Task.includes(:member)
      @member = params[:member_id]

      if @member.present?
        tasks = tasks.where(member_id: @member)
      end
      @tasks = tasks.all
    else
      @tasks = Task.includes(:member)
    end
  end

  def monthly_tasks_report
    @members = Member.joins(:tasks).distinct # for select
    if params[:member].present?
      @start_date = (01.to_s + "-" + params[:select][:month] + "-" + params[:select][:year]).to_date
      @member = Member.find(params[:member])

      @tasks = Task.where(member: @member).where(done_at: @start_date.all_month)
    end
  end

  def feed
    # @pagy, @activities = pagy(PublicActivity::Activity.order("created_at DESC").where(tenant_id: Tenant.current_tenant.id))
    # @activities = PublicActivity::Activity.order("created_at DESC").where(tenant_id: ActsAsTenant.current_tenant.id)
    @activities = PublicActivity::Activity.all
  end

  # example pages that can be here:
  # activity
  # charts and analytics
end
