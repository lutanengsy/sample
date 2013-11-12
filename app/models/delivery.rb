class Delivery < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_no, :total_amount

  has_many :delivery_details, :dependent => :restrict

  validates :delivery_no, :delivery_date, :presence => true
  validates :total_amount, :numericality => true

  def update_totals
    update_attributes(:total_amount => totals)
  end

  def totals
    delivery_details.to_a.sum{ |detail| detail.subtotal }
  end
end
