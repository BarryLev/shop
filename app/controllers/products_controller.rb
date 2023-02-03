class ProductsController < ApplicationController
  def index
    @products = get_products
    @categories = collection_category
  end
  
  def show
    @product = resource
  end

  private

  def get_products
    return collection_product.with_category(params[:id]) if params[:id]
    collection_product
  end

  def collection_product
    Product.sorted_by_position
  end

  def collection_category
    Category.sorted_by_position
  end

  def resource
    Product.find(params[:id])
  end
end
