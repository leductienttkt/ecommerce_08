class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy, :edit, :update]

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      find_product @comment.product_id
      respond
    else
      flash_slq_error @comment
    end
  end

  def destroy
    find_product @comment.product_id
    if @comment.destroy
      respond
    else
      flash_slq_error @comment
    end
  end

  def edit
    respond
  end

  def update
    if @comment.update_attributes comment_params
      respond
    else
      render :edit
    end
  end

  private
  def correct_user
    load_comment
    redirect_to root_url unless current_user.is_user? @comment.user
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "error.comment_not_found"
      redirect_to root_url
    end
  end

  def find_product id
    @product = Product.find_by id: id
    unless @product
      flash[:danger] = t "error.product_not_found"
      redirect_to root_url
    end
  end

  def respond
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def flash_slq_error object
    flash[:danger] = object.errors.full_messages
    redirect_to request.referrer
  end

  def comment_params
    params.require(:comment).permit :content, :product_id
  end
end
