class ProductsController < ApplicationController
  def index
    @products = collection
    @categories = Category.sorted_by_position
  end
  
  def show
    @product = resource
  end

  private

  def collection
    Product.sorted_by_position
  end

  def resource
    Product.find(params[:id])
  end
end
