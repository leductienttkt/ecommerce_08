class SessionsController < ApplicationController
  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "welcome"
      redirect_to request.referer
    else
      flash[:danger] = t "login_error"
      redirect_to request.referer
    end
  end

  def destroy
    log_out if is_logged_in?
    redirect_to root_path
  end
end
