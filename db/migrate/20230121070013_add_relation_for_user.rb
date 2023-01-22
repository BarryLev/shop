class AddRelationForUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :user, null: false, foreign_key: true
    add_reference :addresses, :user, foreign_key: true
    add_reference :orders, :user, foreign_key: true
  end
end
