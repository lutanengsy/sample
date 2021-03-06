class Inventory < ActiveRecord::Base
  attr_accessible :product_id, :doc_no, :qty_in, :qty_out

  validates :doc_no, :product_id, presence: true
  validates :qty_in, :qty_out,    numericality: true

  belongs_to :product

  def self.add_entry(doc_no, product, qty_in, qty_out)
    create(doc_no: doc_no, product_id: product, qty_in: qty_in, qty_out: qty_out)
  end

  def self.remove_entry(doc_no, product, qty_in, qty_out)
    inv = find_entry(doc_no, product, qty_in, qty_out)
    inv.delete if inv
  end

  def self.find_entry(doc_no, product, qty_in, qty_out)
    where(:doc_no => doc_no, :product_id => product, :qty_in => qty_in, :qty_out => qty_out).first
  end

  def update_entry(qty_in, qty_out)
    update_attributes(:qty_in => qty_in, :qty_out => qty_out)
  end
end
