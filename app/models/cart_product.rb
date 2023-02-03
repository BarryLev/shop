class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  scope :destroy_by_ids, -> (product_id, cart_id) {
    find_by(product_id: product_id, cart_id: cart_id).destroy
  }

  scope :pluck_product_ids, -> (cart_id) {
    where(cart_id: cart_id).pluck(:product_id)
  }
end
