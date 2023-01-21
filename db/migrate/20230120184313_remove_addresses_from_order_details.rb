class RemoveAddressesFromOrderDetails < ActiveRecord::Migration[7.0]
  def change
    remove_reference :order_details, :address, null: false, foreign_key: true
  end
end
