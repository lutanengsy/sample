require 'spec_helper'

describe "deliveries/index" do
  before(:each) do
    assign(:deliveries, [
      stub_model(Delivery),
      stub_model(Delivery)
    ])
  end

  it "renders a list of deliveries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
