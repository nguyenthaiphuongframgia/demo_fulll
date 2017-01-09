class Admin::OrdersController < ApplicationController
  before_action :verify_admin

  def index
    @orders = Order.by_name(params[:search]).by_status params[:status]
  end

  def edit
    @order = Order.new
  end

  def update
    @order = Order.find_by id: params[:id]
    @order.status = params[:status]
    @user = User.find @order.user_id
    if @order.save
      case @order.status
      when 0
        flash[:success] = "You had choosed Pending"
      when 1
        flash[:success] = "You had choosed Approve"
        UserMailer.orders_success(@user,"aprove").deliver_now
      when 2
        flash[:success] = "You had choosed Reject"
        UserMailer.orders_success(@user,"Reject").deliver_now
      end
      redirect_to request.referer
    else
      render :edit
    end
  end
end
