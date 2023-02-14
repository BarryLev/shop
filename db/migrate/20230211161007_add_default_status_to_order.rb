class AddDefaultStatusToOrder < ActiveRecord::Migration[7.0]
  def change
    change_column_default :orders, :status, "Completed"
  end
end
