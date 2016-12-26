class RatingsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :load_rate, only: :update

  def create
    @rating = current_user.ratings.build rating_params
    if @rating.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @rating.errors.full_messages
      redirect_to root_url
    end
  end

  def update
    if @rating.update_attributes rating_params
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @rating.errors.full_messages
      redirect_to root_url 
    end
  end

  private
  def rating_params
    params.require(:rating).permit :score, :product_id, :user_id
  end

  def load_rate
    @rating = current_user.ratings.find_by id: params[:id]
    unless @rating
      flash[:danger] = t "error.rating_not_found"
      redirect_to root_url
    end
  end
end
