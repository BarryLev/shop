class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_one :order_detail, dependent: :restrict_with_exception
end
