class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :cart_price, presence: true, numericality: true

  def total_price
    cart_price * quantity
  end
end
