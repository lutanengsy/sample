class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string   "name", :null => false
      t.string   "address"
      t.string   "city"
      t.string   "state"
      t.string   "zip"
      t.string   "contact_no"
      t.string   "contact_person"
      t.string   "terms"
      t.timestamps
    end
  end
end
