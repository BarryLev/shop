class ProductsController < ApplicationController
  def index
    @products = collection
    @categories = category_collection
  end
  
  def show
    @product = resource
  end

  private

  def collection
    Product.sorted_by_position
  end

  def category_collection
    Category.sorted_by_position
  end

  def resource
    Product.find(params[:id])
  end
end
