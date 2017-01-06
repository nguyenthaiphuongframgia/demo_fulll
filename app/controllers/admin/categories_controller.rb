class Admin::CategoriesController < ApplicationController
   before_action :verify_admin
   before_action :find_category, only: [:edit, :update, :destroy]

   def new
    @category = Category.new
  end

  def index
    @categories = Category.order(created_at: :DESC).paginate per_page:
      Settings.per_page.users, page: params[:page]
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_category"
    else
      flash[:danger] = t ".create_product_fail"
    end
    redirect_to request.referer
  end

  def edit
  end

  def update
    @category = Category.find_by id: params[:id]
    if @category.update_attributes(category_params)
      flash[:success] = "category_update"
    else
      flash[:danger] = t "update_fails"
    end
    redirect_to request.referer
  end

  def destroy
    category = Category.find_by id: params[:id]
    if category.destroy
      flash[:success] = t "category_delete"
    else
      flash[:danger] = t "category_not_found"
    end
    redirect_to request.referer
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t ".category_not_found"
    end
  end
end
