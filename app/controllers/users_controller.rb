class UsersController < ApplicationController
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

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "welcome"
    else
      flash[:danger] = t "register_error"
    end
    redirect_to request.referer
  end

  private
  def user_params
    params.require(:user).permit :name, :phone, :email, :address, :password,
      :password_confirmation
  end
end
