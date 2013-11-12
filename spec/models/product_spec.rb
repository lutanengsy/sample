require 'spec_helper'

describe Product do
  it "has a valid factory" do
    FactoryGirl.create(:product).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:product, name: nil).should_not be_valid
  end

  it "should require count_per_pack to be numeric" do
    FactoryGirl.build(:product, count_per_pack: "abc").should_not be_valid
  end

  it "should require price to be numeric" do
    FactoryGirl.build(:product, price: "abc").should_not be_valid
  end

  it "should require srp to be numeric" do
    FactoryGirl.build(:product, srp: "abc").should_not be_valid
  end

  it "returns product name as string" do
    product = FactoryGirl.build(:product)
    product.to_s.should == "Something"
  end

end
