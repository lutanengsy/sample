require 'spec_helper'

describe Customer do
  before :each do
    # instantiate model
  end

  it "has a valid factory" do
    FactoryGirl.create(:customer).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:customer, name: nil).should_not be_valid
  end

  it "should require zip to be numeric" do
    FactoryGirl.build(:customer, zip: "abc").should_not be_valid
  end

  it "should require contact_no to be numeric" do
    FactoryGirl.build(:customer, contact_no: "abc").should_not be_valid
  end

  it "returns customer name as string" do
    customer = FactoryGirl.build(:customer)
    customer.to_s.should == "John Doe"
  end

end
