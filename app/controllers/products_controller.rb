class ProductsController < ApplicationController
  def index
    @products = products
    @categories = category_collection
  end
  
  def show
    @product = resource
  end

  private

  def products
    return product_collection.by_category(params[:id]) if params[:id]
    product_collection
  end

  def product_collection
    Product.sorted_by_position
  end

  def category_collection
    Category.sorted_by_position
  end

  def resource
    Product.find(params[:id])
  end
end
