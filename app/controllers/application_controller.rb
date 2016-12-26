class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless is_logged_in?
      store_location
      flash[:danger] = t "not_logged_in"
      redirect_to root_url
    end
  end
end
