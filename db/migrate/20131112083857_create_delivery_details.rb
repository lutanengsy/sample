class CreateDeliveryDetails < ActiveRecord::Migration
  def change
    create_table :delivery_details do |t|
      t.integer  "quantity",    :default => 0
      t.integer  "product_id",  :null => false
      t.integer  "delivery_id", :null => false
      t.decimal  "price",       :precision => 9, :scale => 2, :default => 0.0
      t.string   "unit",        :null => false
      t.timestamps
    end
  end
end
