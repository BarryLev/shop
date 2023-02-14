class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_one :order_detail, dependent: :destroy
  has_one :address, through: :order_detail  
  
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  def total_price
    products.sum(:price)
  end
end
