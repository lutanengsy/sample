class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string  :doc_no,       :null    => false
      t.integer :product_id,  :null    => false
      t.integer :qty_in,      :default => 0
      t.integer :qty_out,     :default => 0

      t.timestamps
    end
  end
end
