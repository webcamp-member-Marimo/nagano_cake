class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, checked: 1, producing: 2, shipping: 3, done: 4 }
  has_many :order_items
  belongs_to :customer
end
