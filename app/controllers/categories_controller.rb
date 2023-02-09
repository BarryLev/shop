class CategoriesController < ApplicationController
  def show
    @category = resource
    @categories = Category.sorted_by_position
  end

  private

  def resource
    Category.find(params[:id])
  end
end
