class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders
  has_one :order_detail, dependent: :destroy

end
