class OrderItem < ApplicationRecord
  belongs_to :order, dependent: :destroy
end
