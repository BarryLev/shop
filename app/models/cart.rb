class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  scope :clear, -> (cart_id) { find(cart_id).cart_products.destroy_all }
end
