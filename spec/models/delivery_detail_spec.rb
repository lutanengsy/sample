require 'spec_helper'

describe DeliveryDetail do
  it "has a valid factory" do
    FactoryGirl.create(:delivery_detail).should be_valid
  end

  it "is not valid without product id" do
    FactoryGirl.build(:delivery_detail, product_id: nil).should_not be_valid
  end

  it "is not valid without quantity" do
    FactoryGirl.build(:delivery_detail, quantity: nil).should_not be_valid
  end

  it "is not valid without delivery id" do
    FactoryGirl.build(:delivery_detail, delivery_id: nil).should_not be_valid
  end

  it "is not valid without unit" do
    FactoryGirl.build(:delivery_detail, unit: nil).should_not be_valid
  end

  it "is not valid without price" do
    FactoryGirl.build(:delivery_detail, price: nil).should_not be_valid
  end

  it "require quantity to be greater than 0" do
    FactoryGirl.build(:delivery_detail, quantity: 0).should_not be_valid
  end

  it "returns subtotal" do
    detail = FactoryGirl.create(:delivery_detail)
    detail.subtotal.should == 9.99
  end

end
