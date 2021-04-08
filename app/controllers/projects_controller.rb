class ProjectsController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember # for role-based authorization. @current_member.admin?
  include RequireActiveSubscription # no access unless tenant has an active subscription

  before_action :set_project, only: %w[show edit update destroy change_status]

  def index
    @q = Project.ransack(params[:q])
    @pagy, @projects = pagy(@q.result.includes(:client).order("projects.created_at DESC"))
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Projects",
               page_size: "A4",
               template: "projects/project.pdf.erb"
      end
    end
  end

  def change_status
    if params[:status].present? && Project::STATUSES.include?(params[:status])
      @project.update(status: params[:status])
    end
    redirect_to @project, notice: "Status updated to #{@project.status}"
  end

  def show
  end

  def new
    @project = Project.new
    @clients = Client.all
  end

  def edit
    @clients = Client.all
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      @clients = Client.all
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      @clients = Client.all
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
    else
      redirect_to projects_url, alert: 'Project has associations. Can not be destroyed.'
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :client_id, 
        :payment_type, :price, :price_cents, tag_ids: [])
    end
end
