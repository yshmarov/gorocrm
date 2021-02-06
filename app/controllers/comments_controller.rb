class CommentsController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember # for role-based authorization. @current_member.admin?
  include RequireActiveSubscription # no access unless tenant has an active subscription

  before_action :set_commentable

  def new
    @comment = Comment.new
  end
  
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.member = @current_member
    if @comment.save
      redirect_to @commentable, notice: "Comment created"
    else
      render :new
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to @commentable, notice: "Comment deleted"
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    if params[:task_id].present?
      @commentable = Task.find_by_id(params[:task_id])
    elsif params[:client_id].present?
      @commentable = Client.find_by_id(params[:client_id])
    end
  end

end