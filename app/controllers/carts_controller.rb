class CartsController < ApplicationController
  def show
    if current_user
      products_ids = current_user.cart.cart_products.pluck(:product_id)
      @ordered_products = Product.where(id: products_ids)
    else
      if session[:product_id]
        @ordered_products = Product.where(id: session[:product_id])
      end
    end
  end

  def create
    if current_user
      CartProduct.create(product_id: params[:id], cart_id: current_user.cart.id)
    else
      if session[:product_id]
        session[:product_id] << params[:id].to_s  
      else
        session[:product_id] = [params[:id]][0].to_s
      end
    end
    redirect_to root_path
  end

  def destroy
    if current_user
      product_id = params[:id]
      CartProduct.find_by(product_id: product_id, cart_id: current_user.cart.id).destroy
    else
      session[:product_id].delete(params[:id])
    end
    redirect_to get_cart_path
  end
end
