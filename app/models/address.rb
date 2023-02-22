class Address < ApplicationRecord
  has_one :order_detail, dependent: :nullify
  
  belongs_to :user, optional: true
end
