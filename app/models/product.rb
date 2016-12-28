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

  scope :of_ids, -> ids {where id: ids}
  scope :top_order_products, -> {order "number_of_order desc"}
  scope :top_new_products, -> {order "created_at desc"}
  scope :by_category, ->category_id do
    where category_id: category_id if category_id.present?
  end

  scope :by_name, ->name do   
    where "name LIKE '%#{name}%'" if name.present?
  end

  scope :by_min_price, ->min do   
    where "price >= #{min}" if min.present?
  end

  scope :by_max_price, ->max do   
    where "price <= #{max}" if max.present?
  end

  def list_users_rated_product
    User.of_ids Rating.user_ids_by_product self.id
  end

  def rated_by? user
    self.list_users_rated_product.include? user
  end

  def average_rate
    ((ratings.to_a.sum {|item| item.score}).to_f/ratings.count).
      round(Settings.default.round)
  end
end
