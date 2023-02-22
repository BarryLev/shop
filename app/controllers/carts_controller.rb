class CartsController < ApplicationController
  def show
    @cart = resource
    @products = products
  end
  
  def add_product
    if user_signed_in?
      current_user.cart.products << Product.find(params[:product_id])
    else
      store_product
    end
    
    redirect_to root_path
  end
  
  def delete_product
    if user_signed_in?
      current_user.cart.products.destroy(params[:product_id])
    else
      session[:product_id].delete(params[:product_id])
    end
    redirect_to cart_path
  end

  private

  def resource
    current_user.cart if user_signed_in?
  end

  def products
    if user_signed_in?
      resource.products
    else
      Product.where(id: session[:product_ids])
    end
  end

  def store_product
    if session[:product_id].present?
      session[:product_id] << params[:product_id]  
    else
      session[:product_id] = [params[:product_id]]
    end
  end
end
