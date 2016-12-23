class RecentlyViewed < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true

  scope :product_ids_by_user, -> user_id do
    where(user_id: user_id).pluck :product_id
  end
end
