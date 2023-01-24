class PagesController < ApplicationController
  def home
    @cart = true
    @products = Product.all
  end

  def create
    params[:product]
    if current_user
      Cart_product.create(cart_id: current_user.cart.id, product_id: )
    end
  end
end
