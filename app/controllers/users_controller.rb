class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def resend_invitation
    @user = User.find(params[:id])
    if @user.invitation_accepted_at.present?
      redirect_to users_path, alert: "User with email #{@user.email} has already accepted the invitation"
    else
      @user.invite!
      redirect_to users_path, notice: "Invitation resent to #{@user.email}"
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
end