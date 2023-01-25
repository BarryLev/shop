class PagesController < ApplicationController
  def home
    console
    @cart = true
    @products = Product.all.order(:position)
  end
end
