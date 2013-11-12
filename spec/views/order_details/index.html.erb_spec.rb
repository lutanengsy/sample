require 'spec_helper'

describe "order_details/index" do
  before(:each) do
    assign(:order_details, [
      stub_model(OrderDetail),
      stub_model(OrderDetail)
    ])
  end

  it "renders a list of order_details" do
    # render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
