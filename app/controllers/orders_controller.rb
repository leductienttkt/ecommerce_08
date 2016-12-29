class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :load_order, except: [:index, :create]
  
  def index
    @orders = current_user.orders.paginate page: params[:page], 
      per_page: Settings.per_page.order
  end
  
  def show
  end
  
  def create
    @order = current_user.orders.build order_params
    ActiveRecord::Base.transaction do
      if @order.save
        add_order_item
        destroy_cart
      else 
        flash_slq_error @order
      end
    end
  end

  def edit
    respond
  end

  def update
    if @order.update_attributes order_params 
      respond
    else
      flash_slq_error @order
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @order.order_items.each do |item|
        update_product item
      end 
      if @order.destroy
        respond
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
    if Cart.destroy current_cart
      cookies.permanent.signed[:cart_id] = nil
      flash[:success] = t "order_success"
    else
      flash[:success] = t "destroy_cart_fail"
    end
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

  def respond
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
    
  def add_order_item
    current_cart.cart_items.each do |item|
      order_item = @order.order_items.build product_id: item.product_id, 
        quantity: item.quantity, order_price: item.cart_price
      unless order_item.save
        flash_slq_error order_item
      end
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
