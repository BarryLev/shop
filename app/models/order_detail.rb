class OrderDetail < ApplicationRecord
  belongs_to :address
  belongs_to :order

  def add_details(details)
    assign_attributes(first_name: details[:first_name], last_name: details[:last_name], email: details[:email])
  end

  accepts_nested_attributes_for :address
end
