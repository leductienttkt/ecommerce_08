class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  belongs_to :user

  validates :receiver_name, presence: true, length: {maximum: Settings.maximum.name}
  validates :receiver_address, presence: true, length: {maximum: Settings.maximum.address}
  validates :receiver_phone, presence: true, length: {maximum: Settings.maximum.phone}
  validates :user_id, presence: true

  def total_price
    order_items.includes(:product).to_a.sum {|item| item.total_price}
  end

  def total_quantity
    order_items.to_a.sum {|item| item.quantity}
  end
end
