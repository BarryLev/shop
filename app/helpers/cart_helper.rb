module CartHelper
  def cart_empty?
    user_cart_empty = user_signed_in? && current_user.cart.product_ids.empty?
    local_cart_empty = !user_signed_in? && session[:product_id].blank?
    
    user_cart_empty || local_cart_empty
  end
end
