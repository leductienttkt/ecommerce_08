class CartItemsController < ApplicationController
  before_action :find_cart, only: :create
  before_action :load_cart_item, only: [:edit, :update, :destroy]

  def create 
    find_product_by_id params[:product_id]
    if @product.quantity > 0
      @cart_item = @cart.add_product @product
      CartItem.transaction do
        if @cart_item.save
          update_product_quantity
        else
          flash_sql_error @cart_item
        end
      end
    else
      flash[:danger] = t "product.out_of"
      redirect_to request.referrer 
    end
  end

  def edit
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def update
    find_product_by_id @cart_item.product_id
    old_quantity = @cart_item.quantity
    CartItem.transaction do
      if @cart_item.update_attributes cart_item_params
        @product.quantity -= @cart_item.quantity - old_quantity
        save_product
      else
        flash_sql_error @cart_item
      end
    end
  end

  def destroy
    find_product_by_id @cart_item.product_id
    @product.quantity += @cart_item.quantity
    CartItem.transaction do
      if @cart_item.destroy
        save_product
      else
        flash_sql_error @cart_item
      end
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit :quantity
  end

  def load_cart_item
    @cart_item = CartItem.find_by id: params[:id]
    unless @cart_item
      flash[:danger] = t "error.cart_item_not_found"
      redirect_to root_url
    end
  end

  def find_product_by_id id
    @product = Product.find_by id: id
    unless @product
      flash[:danger] = t "error.product_not_found"
      redirect_to root_url
    end
  end

  def update_product_quantity
    @product.quantity -= 1
    save_product
  end

  def find_cart
    unless current_cart
      flash[:danger] = t "error.cart_not_found"
      redirect_to root_url
    end
    @cart = current_cart
  end

  def save_product
    if @product.save
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else
      flash_sql_error @product
    end
  end

  def flash_slq_error object
    flash[:danger] = object.errors.full_messages
    redirect_to root_url
  end
end
