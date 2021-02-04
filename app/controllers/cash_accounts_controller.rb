class CashAccountsController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember # for role-based authorization. @current_member.admin?
  include RequireActiveSubscription # no access unless tenant has an active subscription

  before_action :set_cash_account, only: [:show, :edit, :update, :destroy]

  def index
    @cash_accounts = CashAccount.all
  end

  def show
  end

  def new
    @cash_account = CashAccount.new
  end

  def edit
  end

  def create
    @cash_account = CashAccount.new(cash_account_params)

    if @cash_account.save
      redirect_to @cash_account, notice: 'Cash account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @cash_account.update(cash_account_params)
      redirect_to @cash_account, notice: 'Cash account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cash_account.destroy
    redirect_to cash_accounts_url, notice: 'Cash account was successfully destroyed.'
  end

  private
    def set_cash_account
      @cash_account = CashAccount.find(params[:id])
    end

    def cash_account_params
      params.require(:cash_account).permit(:name)
    end
end
