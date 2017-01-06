class Admin::OrdersController < ApplicationController
  before_action :verify_admin

  def index
    @orders = Order.order(created_at: :DESC).paginate per_page:
      Settings.per_page.users, page: params[:page]
  end

  def edit
    @order = Order.new
  end

  def update
    @order = Order.find_by id: params[:id]
    @order.is_confirm = params[:is_confirm]
    if @order.save
      redirect_to :back
    else
      render :edit
    end
  end
end
