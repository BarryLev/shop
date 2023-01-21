class RemoveAmountFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :amount, :integer
  end
end
