class TasksController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember # for role-based authorization. @current_member.admin?
  include RequireActiveSubscription # no access unless tenant has an active subscription

  before_action :set_task, only: [:show, :edit, :update, :destroy, :change_status]

  def index
    @q = Task.ransack(params[:q])
    @pagy, @tasks = pagy(@q.result.includes(:member, :project, :creator, :tags).order("tasks.created_at DESC"))
  end

  def change_status
    if params[:status].present? && Task::STATUSES.include?(params[:status].to_sym)
      @task.update(status: params[:status])
    end
    if @task.status == "done"
      @task.update(done_at: Time.now)
    end
    redirect_to @task, notice: "Status updated to #{@task.status}"
  end

  def show
    @commentable = @task
    @comment = Comment.new
    @activities = PublicActivity::Activity.order("created_at DESC").where(trackable_type: "Task", trackable_id: @task).all
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.creator_id = @current_member.id
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:project_id, :name, :description, 
        :deadline, :urgent, :status, :done_at, :member_id, :duration_minutes, tag_ids: [])
    end
end
