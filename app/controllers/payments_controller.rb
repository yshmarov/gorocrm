class PaymentsController < ApplicationController
  include SetTenant # include ON TOP of controller that has to be scoped
  include RequireTenant # no current_tenant = no access to entire controller. redirect to root
  include SetCurrentMember # for role-based authorization. @current_member.admin?
  include RequireActiveSubscription # no access unless tenant has an active subscription

  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.all
  end

  def show
  end

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to @payment, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to @payment, notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_url, notice: 'Payment was successfully destroyed.'
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:tenant_id, :payable_id, :payable_type, :amount, :description)
    end
end
