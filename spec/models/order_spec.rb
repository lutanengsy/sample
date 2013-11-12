require 'spec_helper'

describe Order do
  it "has a valid factory" do
    FactoryGirl.create(:order).should be_valid
  end

  it "is invalid without a order date" do
    FactoryGirl.build(:order, order_date: nil).should_not be_valid
  end

  it "is invalid without a total amount" do
    FactoryGirl.build(:order, total_amount: nil).should_not be_valid
  end

  it "should require total amount to be a number" do
    FactoryGirl.build(:order, total_amount: "test").should_not be_valid
  end

  it "should require amount paid to be a number" do
    FactoryGirl.build(:order, amount_paid: "test").should_not be_valid
  end

  it "marks order as delivered" do
    order = FactoryGirl.create(:order)
    order.delivered.should == false
    order.deliver!

    order.delivered.should == true
  end
end
