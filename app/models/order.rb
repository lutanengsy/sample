class Order < ActiveRecord::Base
  attr_accessible :order_date, :customer_id, :total_amount, :delivered, :delivery_date, :paid, :date_paid, :amount_paid

  belongs_to :customer
  has_many   :order_details, :dependent => :restrict

  validates :customer_id, :order_date, :total_amount, :presence => true
  validates :total_amount, :amount_paid, :numericality => true

  def update_totals
    update_attributes(:total_amount => totals)
  end

  def totals
    order_details.to_a.sum{ |detail| detail.subtotal }
  end

  def deliver!
    update_attributes(:delivered => true, :delivery_date => Date.today)
  end

end

 
