class TenantController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
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

  # example pages that can be here:
  # activity
  # charts and analytics
end
