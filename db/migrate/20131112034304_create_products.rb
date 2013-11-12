class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.string :size
      t.integer :count_per_pack, :default => 1
      t.decimal :price,          :default => 0.00, :precision => 5, :scale => 2
      t.decimal :srp,            :default => 0.00, :precision => 5, :scale => 2
      t.integer :balance,        :default => 0
      t.timestamps
    end
  end
end
