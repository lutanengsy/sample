require 'spec_helper'

describe OrderDetail do
  it "has a valid factory" do
    FactoryGirl.create(:order_detail).should be_valid
  end
 
  it "is not valid without product id" do
    FactoryGirl.build(:order_detail, product_id: nil).should_not be_valid
  end

  it "is not valid without quantity" do
    FactoryGirl.build(:order_detail, quantity: nil).should_not be_valid
  end

  it "is not valid without order id" do
    FactoryGirl.build(:order_detail, order_id: nil).should_not be_valid
  end

  it "is not valid without unit" do
    FactoryGirl.build(:order_detail, unit: nil).should_not be_valid
  end

  it "is not valid without price" do
    FactoryGirl.build(:order_detail, unit_price: nil).should_not be_valid
  end

  it "requires quantity greater than 0" do
    FactoryGirl.build(:order_detail, quantity: 0).should_not be_valid
  end

  it "returns subtotal" do
    detail = FactoryGirl.create(:order_detail)
    detail.subtotal.should == 10.00
  end

end
