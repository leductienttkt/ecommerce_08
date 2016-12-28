class SuggestProductsController < ApplicationController
  before_action :logged_in_user
  before_action :load_suggest, only: :destroy

  def index
    @suggest_products = current_user.suggest_products
      .paginate page: params[:page], per_page: Settings.per_page.suggest
  end

  def create
    @suggest = current_user.suggest_products.build suggest_params
    if @suggest.save
      flash[:success] = t "suggest_product.success"
    else
      flash[:danger] = @suggest.errors.full_messages
    end
    redirect_to suggest_products_url
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "suggest_product.success"
    else
      flash[:danger] = @suggest.errors.full_messages
    end
    redirect_to suggest_products_url
  end

  private
  def suggest_params
    params.require(:suggest_product).permit :name, :price, :description,
      :image, :category
  end

  def load_suggest
    @suggest = SuggestProduct.find_by id: params[:id]
    unless @suggest
      flash[:danger] = t "error.suggest_not_found"
      redirect_to suggest_products_url
    end
  end
end
