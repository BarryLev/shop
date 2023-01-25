class OrdersController < ApplicationController
  
  def home
    
  end

  def new
    @order = Order.new
    order.user_id = current_user.id if current_user
    order.status = "completed"
    @order_details = OrderDetails.new
    @order_details.order_id = @order.id
  end
end