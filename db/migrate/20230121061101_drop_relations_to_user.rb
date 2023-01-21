class DropRelationsToUser < ActiveRecord::Migration[7.0]
  def change
    remove_reference :carts, :user, null: false, foreign_key: true
    remove_reference :addresses, :user, null: true, foreign_key: true
    remove_reference :orders, :user, null: true, foreign_key: true
  end
end
