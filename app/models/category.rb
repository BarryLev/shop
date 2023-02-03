class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :sorted_by_position, -> { all.order(:position) }
end
