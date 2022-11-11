class OrderItem < ApplicationRecord
  enum making_status: { unable: 0, waiting: 1, producing: 2, done: 3 }
  belongs_to :order
  belongs_to :item
  
  def subtotal
    item.tax_price * amount
  end
end
