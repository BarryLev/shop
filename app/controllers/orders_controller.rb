class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @orders = collection
  end

  def show
    @order = resource
  end

  def create
    @order = Order.new(status: "Completed", ordered_at: Date.today)
    @order.build_order_detail(order_params)
    @order.order_detail.build_address(address_params)

    @order.user_id = current_user.id if user_signed_in?

    if @order.save!
      clear_cart
      return redirect_back_or_to root_path
    end

    render :new
  end

  def new
    if user_signed_in?
      return redirect_to root_path if current_user.cart.product_ids.empty?
    else
      redirect_to root_path if session[:product_id].blank?
    end
  end

  private
  
  def collection
    current_user.orders
  end

  def resource
    collection.find(params[:id])
  end

  def order_params
    params.require(:order_detail).permit(:first_name, :last_name, :email)
  end

  def address_params
    params.require(:address).permit(:country, :city, :street, :comment)
  end

  def clear_cart
    current_user.cart.clear
  end
end
