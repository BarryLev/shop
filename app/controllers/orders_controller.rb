class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :cart_empty, only: :new

  def index
    @orders = collection
  end

  def show
    @order = resource
  end

  def create
    @order = Order.new(ordered_at: Date.today, user_id: current_user&.id)
    @order.build_order_detail(order_detail_params)
    @order.order_detail.build_address(address_params)

    if @order.save
      clear_cart
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @order = Order.new
    @order.build_order_detail
    @order.order_detail.build_address
  end

  private

  def cart_empty
    if cart_empty?
      flash[:error] = "Your cart is empty, you can't place your order"
      redirect_to root_path
    end
  end

  def cart_empty?
    user_cart_empty = user_signed_in? && current_user.cart.product_ids.empty?
    local_cart_empty = !user_signed_in? && session[:product_id].blank?
    
    user_cart_empty || local_cart_empty
  end
  
  def collection
    current_user.orders
  end

  def resource
    collection.find(params[:id])
  end

  def order_detail_params
    params[:order].require(:order_detail).permit(:first_name, :last_name, :email)
  end

  def address_params
    params.dig(:order, :order_detail).require(:address).permit(:country, :city, :street, :comment)
  end

  def clear_cart
    current_user.cart.clear
  end
end
