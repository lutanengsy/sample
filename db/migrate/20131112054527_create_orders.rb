class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id, :null => false
      t.date    :order_date
      t.decimal :total_amount, :precision => 9, :scale => 2, :default => 0.00
      t.boolean :delivered,    :default => false
      t.date    :delivery_date
      t.boolean :paid,         :default => false
      t.date    :date_paid
      t.decimal :amount_paid,  :precision => 9, :scale => 2, :default => 0.00
      t.timestamps
    end
  end
end
