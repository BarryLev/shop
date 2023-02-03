class CartsController < ApplicationController
  def show
    @ordered_products = get_products
  end

  def create
    if user_signed_in?
      CartProduct.create(product_id: params[:id], cart_id: current_user.cart.id)
    else
      push_product_to_session
    end
    redirect_to root_path
  end

  def destroy
    if user_signed_in?
      CartProduct.destroy_by_ids(params[:id], current_user.cart.id)
    else
      session[:product_id].delete(params[:id])
    end
    redirect_to get_cart_path
  end

  private

  def get_products
    if user_signed_in?
      products_ids = current_user.get_products_by_id
      return Product.where(id: products_ids)
    elsif session[:product_id]
      return Product.where(id: session[:product_id])
    end
  end

  def push_product_to_session
    if session[:product_id]
      session[:product_id] << "#{params[:id].to_s}"  
    else
      session[:product_id] = [params[:id]][0].to_s
    end
  end
end
