require 'spec_helper'

describe "delivery_details/index" do
  before(:each) do
    assign(:delivery_details, [
      stub_model(DeliveryDetail),
      stub_model(DeliveryDetail)
    ])
  end

  it "renders a list of delivery_details" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
