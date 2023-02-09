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
    redirect_to carts_path
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
    if session[:product_id].blank?
      session[:product_id] << params[:id].to_s  
    else
      session[:product_id] = [params[:id].to_s]
    end
  end
end
