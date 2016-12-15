class SuggestProduct < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name,  presence: true, length: {maximum: Settings.maximum.name}
  validates :price, presence: true, numericality: true
  validates :user_id, presence: true
  validates :category_id, presence: true
end
