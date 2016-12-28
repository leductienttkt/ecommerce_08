class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Product.by_name(params[:name])
      .by_category(params[:category]).by_min_price(params[:min])
      .by_max_price params[:max] 
    if params[:rate].present?
      @products = @products.select do |product| 
        product.average_rate > params[:rate].to_i
      end
    end
  end

  def show
    @cart_item = CartItem.new
    if is_logged_in?
      save_recently_view
      if @product.rated_by? current_user
        @rating = current_user.ratings.find_by product_id: @product.id
        unless @rating
          redirect_to @product
          flash[:danger] = "error.rating_not_found"
        end
      else
        @rating = Rating.new
      end
    end
  end

  private
  def load_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t "error.product_not_found"
      redirect_to root_url
    end
  end

  def save_recently_view
    recently_view = current_user.recently_vieweds.find_by_product_id @product.id
    unless recently_view
      recently_view = current_user.recently_vieweds.build product_id: @product.id
      if recently_view.save   
        if current_user.recently_vieweds.count > Settings.default.recently
          RecentlyViewed.destroy current_user.recently_vieweds.first
        end
      else
        flash[:danger] = recently_view.errors.full_messages
        redirect_to root_url
      end
    end
  end
end
