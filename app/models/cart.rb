class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  def clear
    cart_products.destroy_all
  end

  def destroy_product(product_id)
  cart_products.find(product_id).destroy
  end
end
