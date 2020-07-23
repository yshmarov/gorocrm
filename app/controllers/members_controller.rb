class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  include SetTenant #set ActsAsTenant.current_tenant
  include RequireTenant #no current_tenant = no access to entire controller

  before_action :set_current_member
  def set_current_member
    @current_member = Member.find_by(user: current_user)
  end

  before_action :require_admin, only: [:invite, :edit, :update, :destroy]
  def require_admin
    if @current_member.admin?
      # success
    else
      redirect_to members_path, alert: "You are not authorized"
    end
  end

  def index
    @members = Member.includes(:user, :tenant).all #"includes" for eager loading
  end

  def invite
    email = params[:email]
    user_from_email = User.where(email: email).first
    if email.present?
      if user_from_email.present? #user exists in the database
        if Member.where(user: user_from_email).any? #user is a member in current_tenant
          redirect_to members_path, alert: "The organization #{current_tenant.name} already has a user with the email #{email}"
        else #user is not a member of current_tenant
          new_member = Member.create!(user: user_from_email) #create member for existing user
          MemberMailer.invited(new_member).deliver_later
          redirect_to members_path, notice: "#{email} was invited to join the organization #{current_tenant.name}"
        end
      elsif user_from_email.nil? #invite new user to a tenant
        new_user = User.invite!({ email: email }, current_user) #devise invitable create user and send email. invited_by current_user
        if new_user.persisted?
          Member.create!(user: new_user) #make new user part of this tenant
          redirect_to members_path, notice: "#{email} was invited to join the tenant #{current_tenant.name}"
        else
          redirect_to members_path, alert: "Something went wrong. Please try again"
        end
      end
    else
      redirect_to members_path, alert: "No email provided!"
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(*Member::ROLES)
    end
end
