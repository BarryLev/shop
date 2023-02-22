class RenameOrderProductsToProductOrders < ActiveRecord::Migration[7.0]
  def change
    rename_table :product_orders, :order_products
  end
end
