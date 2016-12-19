class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: {maximum: Settings.maximum.content}
  validates :user_id, presence: true
  validates :product_id, presence: true
end
