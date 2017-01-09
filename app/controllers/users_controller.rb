class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to request.referer
    end
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "welcome"
    else
      flash[:danger] = t "register_error"
    end
    redirect_to root_path
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_success"
    else
      flash[:danger] = t "profile_fails"
    end
    redirect_to request.referer
  end

  private
  def user_params
    params.require(:user).permit :name, :phone, :email, :address, :password,
      :password_confirmation, :picture
  end

  def correct_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
    else
      redirect_to root_url  unless @user == current_user
    end
  end
end
