class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :order_id, presence: true
  validates :product_id, presence: true
end
