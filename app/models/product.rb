class Product < ApplicationRecord
  belongs_to :category
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products, dependent: :destroy

  scope :sorted_by_position, -> { all.order(:position) }
  scope :with_category, -> (category) { where(category_id: category) }
end
