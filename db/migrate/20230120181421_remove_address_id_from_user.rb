class RemoveAddressIdFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :address, null: false, foreign_key: true
  end
end
