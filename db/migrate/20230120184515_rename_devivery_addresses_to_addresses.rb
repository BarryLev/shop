class RenameDeviveryAddressesToAddresses < ActiveRecord::Migration[7.0]
  def change
    rename_table :delivery_addresses, :addresses
  end
end
