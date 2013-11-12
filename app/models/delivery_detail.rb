class DeliveryDetail < ActiveRecord::Base
  attr_accessible :delivery_id, :price, :product_id, :quantity, :unit
 
  after_save    :update_delivery_total

  belongs_to :delivery
  belongs_to :product

  validates :product_id, :quantity, :delivery_id, :unit, :price, :presence => true
  validates :quantity,   :numericality => { :greater_than => 0 }

  def update_delivery_total
    delivery.update_totals
  end

  def subtotal
    quantity * price
  end


  
end
