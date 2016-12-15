class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :score, presence: true, numericality: {only_integer: true}
  validates :user_id, presence: true
  validates :product_id, presence: true
end
