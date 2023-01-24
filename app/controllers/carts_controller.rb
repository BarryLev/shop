class CartsController < ApplicationController
  def index
    if current_user
      products_ids = current_user.cart.cart_products.pluck(:product_id)
      @ordered_products = Product.where(id: products_ids)
      p 
    end
  end

  def destroy
    product = params[:product]
    product.cart_product.destroy
  end
end
