class Delivery < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_no, :total_amount

  validates :delivery_no, :delivery_date, :presence => true
  validates :total_amount, :numericality => true
end
