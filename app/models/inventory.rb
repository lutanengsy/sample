class Inventory < ActiveRecord::Base
  attr_accessible :product_id, :doc_no, :qty_in, :qty_out

  validates :doc_no, :product_id, presence: true
  validates :qty_in, :qty_out,    numericality: true

  belongs_to :product

  
end
