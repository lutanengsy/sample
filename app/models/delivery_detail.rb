class DeliveryDetail < ActiveRecord::Base
  attr_accessible :delivery_id, :price, :product_id, :quantity, :unit
 
  after_save    :update_delivery_total
  after_create  :update_inventory
  after_destroy :remove_inv_entry, :update_delivery_total
  after_update  :update_inventory_entry, :update_delivery_total

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

  def update_inventory
    doc_no  = "DR #{self.delivery_id}"
    product = self.product_id

    Inventory.add_entry(doc_no, product, self.quantity, 0)
    Product.update_balance(product, self.quantity, 0)
  end

  def update_inventory_entry
    if self.changed?
      inv = Inventory.find_entry("DR #{self.delivery_id}", self.product_id, quantity_was, 0)
      inv.update_entry(quantity,0) if inv

      Product.update_balance(self.product_id, quantity, quantity_was)
    end
  end

  def remove_inv_entry
    Inventory.remove_entry("DR #{self.delivery_id}", self.product_id, self.quantity, 0)
    Product.update_balance(self.product_id, 0, self.quantity)
  end
  
end
