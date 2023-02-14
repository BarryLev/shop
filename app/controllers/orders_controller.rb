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
      if user_signed_in?
        @order.products << current_user.cart.products.destroy_all
      else
        @order.products << Product.find(session[:product_id])
        session[:product_id].clear
      end
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
    if helpers.cart_empty?
      flash[:error] = "Your cart is empty, you can't place your order"
      redirect_to root_path
    end
  end
  
  def collection
    current_user.orders
  end

  def resource
    collection.find(params[:id])
  end

  def order_detail_params
    if user_signed_in?
      {
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        email: current_user.email
      }
    else
      params[:order].require(:order_detail).permit(:first_name, :last_name, :email)
    end
  end

  def address_params
    params.dig(:order, :order_detail).require(:address).permit(:country, :city, :street, :comment)
  end
end
