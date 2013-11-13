require 'spec_helper'

describe Inventory do

  it "has a valid factory" do
    FactoryGirl.create(:inventory).should be_valid
  end

  it "is invalid without doc no" do
    FactoryGirl.build(:inventory, doc_no: nil).should_not be_valid
  end

  it "is invalid without product id" do
    FactoryGirl.build(:inventory, product_id: nil).should_not be_valid
  end
 
  it "is invalid without qty in" do
    FactoryGirl.build(:inventory, qty_in: nil).should_not be_valid
  end

  it "is invalid without qty out" do
    FactoryGirl.build(:inventory, qty_out: nil).should_not be_valid
  end

  it "is associated with a product" do
    product   = FactoryGirl.create(:product)
    inventory = FactoryGirl.create(:inventory, product_id: product.id)
    inventory.product.should_not be_nil
  end

end
