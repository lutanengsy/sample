class Product < ActiveRecord::Base
  attr_accessible :code, :count_per_pack, :name, :price, :size, :srp, :balance

  has_many :order_details,    :dependent => :restrict
  has_many :delivery_details, :dependent => :restrict

  validates :name, :presence => true, :uniqueness => true
  validates :count_per_pack, :price, :numericality => true, :allow_nil => true
  validates :srp, :numericality => true, :allow_nil => true

  def self.update_balance(product_id,qty_in,qty_out)
    product = find(product_id)

    if product
      new_balance = product.balance + qty_in - qty_out
      product.update_attributes(:balance => new_balance)
    end
  end

  def to_s
    name
  end

  def subtotal
    balance * price
  end

end


