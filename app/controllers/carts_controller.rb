class CartsController < ApplicationController
  def show
    @products = collection
  end

  def destroy
    binding.pry
    if user_signed_in?
      current_user.cart.cart_products.find_by(product_id: params[:id]).destroy
    else
      session[:product_id].delete(params[:id])
    end
    redirect_to carts_path
  end

  def update
    binding.pry
    if user_signed_in?
      CartProduct.create(product_id: params[:id], cart_id: current_user.cart.id)
    else
      store_product
    end
    redirect_to root_path
  end

  private

  def collection
    if user_signed_in?
      return Cart.find_by(user_id: current_user.id).products
    elsif session[:product_id]
      Product.find(session[:product_id])
    end
  end

  def store_product
    if session[:product_id].blank?
      session[:product_id] << params[:id].to_s  
    else
      session[:product_id] = [params[:id].to_s]
    end
  end
end
