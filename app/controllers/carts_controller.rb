class CartsController < ApplicationController
  def show
    @products = resource
  end

  def create
    if user_signed_in?
      CartProduct.create(product_id: params[:id], cart_id: current_user.cart.id)
    else
      store_product
    end
    redirect_to root_path
  end

  def destroy
    if user_signed_in?
      current_user.cart.destroy_product(params[:id])
    else
      session[:product_id].delete(params[:id])
    end
    redirect_to cart_path
  end

  private

  def resource
    if user_signed_in?
      products_ids = current_user.get_product_ids
      return Product.find(products_ids)
    elsif session[:product_id]
      Product.find(session[:product_id])
    end
  end

  def store_product
    if session[:product_id]
      session[:product_id] << "#{params[:id].to_s}"  
    else
      session[:product_id] = [params[:id].to_s]
    end
  end
end
