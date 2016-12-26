class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :load_order, only: [:show, :edit, :update, :destroy]
  
  def index
    @orders = current_user.orders.paginate page: params[:page], 
      per_page: Settings.per_page.order
  end
  
  def show 
  end
  
  def create
    @order = current_user.orders.build order_params
    Order.transaction do
      if @order.save
        current_cart.cart_items.each do |item|
      	  order_item = @order.order_items.
            build product_id: item.product_id, quantity: item.quantity
          unless order_item.save
            flash_slq_error order_item
          end
        end
        destroy_cart
      else 
        flash_slq_error @order
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def update
    if @order.update_attributes order_params 
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else
      flash_slq_error @order
    end
  end

  def destroy
    OrderItem.transaction do
      @order.order_items.each do |item|
        update_product item
      end 
      if @order.destroy
        respond_to do |format|
          format.html {redirect_to request.referrer}
          format.js
        end
      else
        flash_slq_error @order
      end
    end
  end

  private
  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "error.order_not_found"
      redirect_to root_url
    end
  end

  def destroy_cart
    Cart.destroy current_cart
    cookies.permanent.signed[:cart_id] = nil
    flash[:success] = t "order_success"
    redirect_to root_path
  end

  def update_product item
    product = Product.find_by id: item.product_id
    unless product
      flash[:danger] = t "error.product_not_found"
      redirect_to root_url
    end
    product.quantity += item.quantity
    unless product.save
      flash_slq_error product
    end
  end

  def order_params
    params.require(:order).
      permit :receiver_name, :receiver_phone, :receiver_address 
  end

  def flash_slq_error object
    flash[:danger] = object.errors.full_messages
    redirect_to root_url
  end
end	
