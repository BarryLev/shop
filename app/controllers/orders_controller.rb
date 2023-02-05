class OrdersController < ApplicationController
  before_action :require_login, only: [:index, :show]

  def index
    @orders = collection
  end

  def show
    @order = resource
    @total_price = total_price
  end

  def create
    @order = Order.new(status: "Completed", ordered_at: Date.today)
    @order.build_order_detail(permitted_params_order_detail)
    @order.order_detail.build_address(permitted_params_address)
    
    if @order.save
      clear_cart
      return redirect_back_or_to root_path
    end

    render :new
  end

  def new
    if user_signed_in?
      return redirect_to root_path if current_user.get_product_ids.empty?
    else
      redirect_to root_path if session[:product_id].empty?
    end
  end

  private

  def require_login
    if !user_signed_in?
      redirect_back_or_to root_path
    end
  end
  
  def collection
    current_user.orders
  end

  def resource
    collection.find(params[:id])
  end

  def permitted_params_order_detail
    params.require(:order_detail).permit(:first_name, :last_name, :email)
  end

  def permitted_params_address
    params.require(:address).permit(:country, :city, :street, :comment)
  end

  def clear_cart
    current_user.cart.clear
  end

  def total_price
    @order.products.pluck(:price).inject(&:+)
  end
end
