class TasksController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember # for role-based authorization. @current_member.admin?
  include RequireActiveSubscription # no access unless tenant has an active subscription

  before_action :set_task, only: %w[show edit update destroy change_status]

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
    @task.create_activity :update, parameters: {status: @task.status}

    text = "#{url_for controller: "tasks", action: "show"} status: #{@task.status}"
    TelegramMailer.group_message(text).deliver_now
    TelegramMailer.private_message(text, current_user).deliver_now
    redirect_to @task, notice: "Status updated to #{@task.status}"
  end

  def show
    @commentable = @task
    @comment = Comment.new
    #@activities = PublicActivity::Activity.includes(:trackable).order("created_at DESC").where(trackable_type: "Task", trackable_id: @task).all
    #@activities = PublicActivity::Activity.order("created_at DESC").where(trackable: @task)
    #@activities = PublicActivity::Activity.includes(:trackable).order("created_at DESC").where(trackable: @task)
    @activities = @task.activities.order("created_at DESC")
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
    Task.public_activity_off
    if @task.update(task_params)
      Task.public_activity_on
      @task.create_activity :update, parameters: {
        project: @task.project.to_s,
        name: @task.name,
        member: @task.member.to_s,
        creator: @task.creator.to_s,
        urgent: @task.urgent,
        status: @task.status,
        deadline: @task.deadline,
        done_at: @task.done_at,
        duration: @task.duration_minutes,
        description: @task.description
        }
      #@task.create_activity :update, parameters: {duration: @task.duration_minutes}
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
