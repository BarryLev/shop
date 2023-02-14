# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]  

  # POST /resource
  def create
    super
    user_cart = Cart.create(user_id: current_user.id)
    session[:product_id].uniq.each do |product_id|
      CartProduct.create(cart_id: user_cart.id, product_id: product_id)
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
  end
end
