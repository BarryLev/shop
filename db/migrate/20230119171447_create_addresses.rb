class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :locality
      t.string :street
      t.integer :house

      t.timestamps
    end
  end
end
