class PagesController < ApplicationController
  def home
    if params[:id]
      @products = Product.where(category_id: params[:id]).order(:position)
    else
      @products = Product.all.order(:position)
    end
    
    @categories = Category.all.order(:position)
  end
end
