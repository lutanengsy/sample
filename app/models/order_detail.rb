class OrderDetail < ActiveRecord::Base
  attr_accessible :quantity, :unit, :product_id, :unit_price, :order_id

  after_save :update_order_total

  validates :unit, :product_id, :order_id, presence: true
  validates :unit_price, numericality: true
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :order
  belongs_to :product

 def update_order_total
    order.update_totals
  end

  def subtotal
    quantity * unit_price
  end

end
