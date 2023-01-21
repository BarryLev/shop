class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
