class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_one :order_detail, dependent: :destroy
  has_one :address, through: :order_detail
  
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  accepts_nested_attributes_for :order_detail

  def total_price
    products.sum(:price)
  end
end
