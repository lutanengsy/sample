class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string  :delivery_no, :null => false
      t.date    :delivery_date
      t.decimal :total_amount, :precision => 12, :scale => 2, :default => 0.00
      t.timestamps
    end
  end
end
