class DropOrderProducts < ActiveRecord::Migration[7.0]
  def change
    drop_table :order_products
  end
end
