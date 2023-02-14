class CartsController < ApplicationController
  def show
    @cart = resource
  end

  def destroy
    if user_signed_in?
      current_user.cart.products.destroy(params[:id])
    else
      session[:product_id].delete(params[:id])
    end
    redirect_to cart_path
  end

  def update
    if user_signed_in?
      current_user.cart.products << Product.find(params[:id])
    else
      store_product
    end
    redirect_to root_path
  end

  private

  def resource
    if user_signed_in?
      current_user.cart
    elsif session[:product_id].present?
      cart = Cart.new
      cart.products << Product.find(session[:product_id])
      cart
    end
  end

  def store_product
    if session[:product_id].present?
      session[:product_id] << params[:id]  
    else
      session[:product_id] = [params[:id]]
    end
  end
end
