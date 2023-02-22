# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]  

  # POST /resource
  def create
    super
    if user_signed_in?
      user_cart = Cart.create(user_id: current_user.id)
      if session[:product_id].present?
        session[:product_id].uniq.each do |product_id|
          CartProduct.create(cart_id: user_cart.id, product_id: product_id)
        end
      end
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
  end
end
