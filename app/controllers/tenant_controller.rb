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

  def tasks_report
    @members = Member.joins(:tasks).distinct # for select
    @projects = Project.joins(:tasks).distinct # for select
    @clients = Client.joins(:tasks).distinct # for select
    if params.has_key?(:member)
      tasks = Task.includes(:member, :project)
      if params[:select][:month].present? && params[:select][:year].present?
        @start_date = (01.to_s + "-" + params[:select][:month] + "-" + params[:select][:year]).to_date
        tasks = tasks.where(done_at: @start_date.all_month)
      end
      if params[:member].present?
        @member = Member.find(params[:member])
        tasks = tasks.where(member: @member)
      end
      if params[:project].present?
        @project = Project.find(params[:project])
        tasks = tasks.where(project: @project)
      end
      if params[:client].present?
        @client = Client.find(params[:client])
        tasks = tasks.where(projects: {client_id: @client.id})
      end

      @tasks = tasks.all
      @minutes_spent = @tasks.map(&:duration_minutes).sum
    end
  end

  def activity
    @pagy, @activities = pagy(PublicActivity::Activity.order("created_at DESC").where(tenant_id: ActsAsTenant.current_tenant.id))
  end

  def charts
  end

end
