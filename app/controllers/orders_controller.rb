class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :check_products_presence, only: :new

  def index
    @orders = collection
  end

  def show
    @order = resource
  end

  def create
    if user_signed_in?
      @order = Order.new(order_params.merge(user_id: current_user.id, product_ids: current_user.cart.products.destroy_all.pluck(:id)))
      @order.order_detail.add_details(get_user_details)
    else
      @order = Order.new(order_params.merge(product_ids: session[:product_id]))
      session[:product_id].clear
    end

    if @order.save!
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

  def check_products_presence
    if cart_empty?
      flash[:warning] = "Your cart is empty, you can't place your order"
      redirect_to root_path
    end
  end

  def cart_empty?
    if user_signed_in?
      current_user.cart.product_ids.empty?
    else
      session[:product_id].blank?
    end
  end
  
  def collection
    current_user.orders
  end

  def resource
    collection.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      order_detail_attributes: [:first_name, :last_name, :email,
        address_attributes: [:country, :city, :street, :comment]
      ]
    )
  end

  def get_user_details
    {
      first_name: current_user.first_name,
      last_name: current_user.last_name,
      email: current_user.email
    }
  end
end
