class CreateDeliveryAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_addresses do |t|
      t.string :country
      t.string :city
      t.string :street
      t.text :comment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
