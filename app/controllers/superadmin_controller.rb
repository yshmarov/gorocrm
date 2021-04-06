class SuperadminController < ApplicationController

  def tenants
    @q = Tenant.order(created_at: :desc).ransack(params[:q])
    @tenants = @q.result.includes(:members, :users, members: [:user]).order(created_at: :desc)
    render "tenants/index"
  end

  def users
    @q = User.order(created_at: :desc).ransack(params[:q])
    @users = @q.result.includes(:identities, :members, :tenants, members: [:tenant]).order(created_at: :desc)
  end

end
