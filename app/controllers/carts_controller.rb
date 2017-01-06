class CartsController < ApplicationController
  before_action :find_cart, only: [:show, :destroy]
  before_action :new_user

  def show
    @order = Order.new
  end

  def destroy
    ActiveRecord::Base.transaction do
      current_cart.cart_items.each do |item|
        product = item.product
        product.quantity += item.quantity
        unless product.save
          flash[:danger] = product.errors.full_messages
          redirect_to root_url
        end
      end
      Cart.destroy current_cart
      cookies.permanent.signed[:cart_id] = nil
      redirect_to root_url
    end
  end
  
  private
  def find_cart
    unless current_cart
      flash[:danger] = t "error.cart_not_found"
      redirect_to root_url
    end
  end
end
