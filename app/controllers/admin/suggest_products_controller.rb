class Admin::SuggestProductsController < ApplicationController
  before_action :verify_admin

  def index
    @suggest_products = SuggestProduct.
      by_name(params[:search]).paginate per_page: Settings.per_page.suggest,
        page: params[:page]
  end

  def edit
    @suggest_products = SuggestProduct.new
  end

  def update
    @suggest_products = SuggestProduct.find_by id: params[:id]
    @suggest_products.status = params[:status]
    if @suggest_products.save
      redirect_to admin_suggest_products_path
    else
      render :edit
    end
  end

  def destroy
    suggest = SuggestProduct.find_by id: params[:id]
    if suggest.destroy
      flash[:success] = t ".product_delete"
    else
      flash[:danger] = t ".product_not_found"
    end
    redirect_to request.referer
  end
end
