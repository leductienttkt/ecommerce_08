class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def add_product product
    current_item = cart_items.find_by_product_id product.id
    if current_item 
      current_item.quantity += 1
    else
      current_item = cart_items.build product_id: product.id, cart_price: product.price
    end
    current_item
  end

  def total_price
    cart_items.includes(:product).to_a.sum {|item| item.total_price}
  end

  def total_quantity
    cart_items.to_a.sum {|item| item.quantity}
  end
end
