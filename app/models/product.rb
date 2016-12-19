class Product < ApplicationRecord
  has_many :recently_vieweds, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :category

  validates :name,  presence: true, length: {maximum: Settings.maximum.name}
  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :category_id, presence: true
end
