class ChangePriorityAtCategories < ActiveRecord::Migration[7.0]
  def change
    rename_column :categories, :priority, :position
  end
end
