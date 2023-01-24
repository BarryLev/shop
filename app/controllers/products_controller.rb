class ProductsController < ApplicationController
  def show
    @product = Product.find_by(position: params[:position])
  end
end
