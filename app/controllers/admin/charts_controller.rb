class Admin::ChartsController < ApplicationController
  def index
    @order = Order.by_search params[:start_day], params[:end_day]
    @order_array = @order.group_by(&:group_by_order).map {|k,v| [k, v.length]}.sort
    @user = User.by_search_user params[:start_day], params[:end_day]
    @user_array = @user.group_by(&:group_by_user).map {|k,v| [k, v.length]}.sort
  end
end
