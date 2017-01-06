module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
    @current_user = nil
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

  def is_logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_cart
    @current_cart ||= Cart.find_by id: cookies.signed[:cart_id]
  end
end
