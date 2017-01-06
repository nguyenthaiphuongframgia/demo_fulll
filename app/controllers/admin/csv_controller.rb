class Admin::CsvController < ApplicationController
  before_action :verify_admin

  def create
    if Product.import params[:file]
       flash[:success] = t ".product_imported"
       redirect_to :back
    else
      flash[:success] = t "import_fails"
      redirect_to :back
    end
  end

  def import
    Product.import(params[:file])
    redirect_to root_url, notice: t(".product_imported")
  end

end
