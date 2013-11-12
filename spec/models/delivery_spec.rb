require 'spec_helper'

describe Delivery do
  it "has a valid factory" do
    FactoryGirl.create(:delivery).should be_valid
  end

  it "is invalid without a delivery no" do
    FactoryGirl.build(:delivery, delivery_no: nil).should_not be_valid
  end

  it "is invalid without a delivery date" do
    FactoryGirl.build(:delivery, delivery_date: nil).should_not be_valid
  end

  it "is invalid without a total amount" do
    FactoryGirl.build(:delivery, total_amount: nil).should_not be_valid
  end

  it "should require total amount to be a number" do
    FactoryGirl.build(:delivery, total_amount: "test").should_not be_valid
  end

 
end

