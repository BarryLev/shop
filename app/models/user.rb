class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :nullify

  def get_products_by_id
    cart.cart_products.pluck(:product_id)
  end
end
