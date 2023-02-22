class AddDefaultStatusAndOrderedAtToOrder < ActiveRecord::Migration[7.0]
  def change
    change_column_default :orders, :status, "completed"
    change_column_default :orders, :ordered_at, Date.today
  end
end
