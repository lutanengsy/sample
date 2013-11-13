class OrderDetail < ActiveRecord::Base
  attr_accessible :quantity, :unit, :product_id, :unit_price, :order_id

  after_save    :update_order_total
  after_create  :update_inventory
  after_destroy :remove_inv_entry, :update_order_total
  after_update  :update_inventory_entry, :update_order_total

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

  def update_inventory
    doc_no  = "OS #{self.order_id}"
    product = self.product_id

    Inventory.add_entry(doc_no, product, 0, self.quantity)
    Product.update_balance(product, 0, self.quantity)
  end

   def update_inventory_entry
    if self.changed?
      inv = Inventory.find_entry("OS #{self.order_id}", self.product_id, 0, quantity_was)
      inv.update_entry(0,quantity) if inv

      Product.update_balance(self.product_id, quantity_was, quantity)
    end
  end

  def remove_inv_entry
    Inventory.remove_entry("OS #{self.order_id}", self.product_id, 0, self.quantity)
    Product.update_balance(self.product_id, self.quantity, 0)
  end
end
