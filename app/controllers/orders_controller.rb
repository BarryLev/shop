class OrdersController < ApplicationController
  def index
    if user_signed_in?
      @orders = collection
    end
  end

  def show
    if user_signed_in?
      @order = resource
      @products = Product.find(@order.product_ids)
      @address = @order.order_detail.address
      @total_price = total_price
    end
  end

  def create
    initialize_order_and_relations
    
    return render :new unless (@order.save && @address.save)

    @order_detail.order_id = @order.id
    @order_detail.address_id = @address.id
    
    initialize_order_product

    return render :new unless @order_detail.save

    clear_cart

    redirect_to root_path
  end

  # Add placeholder for authorized user
  def new
    if user_signed_in?
      return redirect_to root_path if current_user.get_products_by_id.empty?
    else
      return redirect_to root_path if session[:product_id].empty?
    end
  end

  private
  
  def collection
    current_user.orders
  end

  def resource
    collection.find(params[:id])
  end

  def initialize_order_and_relations
    @order = Order.new(status: "Completed", ordered_at: Date.today)
    @order_detail = OrderDetail.new(permitted_params(:order_detail))
    @address = Address.new(permitted_params(:address))

    set_user_id_to_address_and_order
  end

  def initialize_order_product
    if user_signed_in?
      product_ids = current_user.get_products_by_id
    else
      product_ids = session[:product_id]
    end

    product_ids.each do |product_id|
      ProductOrder.create(order_id: @order.id, product_id: product_id, amount: 1)
    end
  end

  def permitted_params(req)
    return params.require(:order_detail).permit(:first_name, :last_name, :email) if req == :order_detail
    return params.require(:address).permit(:country, :city, :street, :comment) if req == :address
  end

  def set_user_id_to_address_and_order
    if user_signed_in?
      @order.user_id = current_user.id
      @address.user_id = current_user.id
    end
  end

  def clear_cart
    Cart.clear(current_user.cart.id)
  end

  def total_price
    @products.pluck(:price).inject(&:+)
  end
end
