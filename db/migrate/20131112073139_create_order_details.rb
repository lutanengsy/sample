class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.integer :order_id, :null => false
      t.integer :quantity, :default => 0
      t.string  :unit
      t.integer :product_id, :null => false
      t.decimal :unit_price, :precision => 9, :scale => 2, :default => 0.00

      t.timestamps
    end
  end
end
