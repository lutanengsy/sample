require 'spec_helper'

describe "delivery_details/show" do
  before(:each) do
    @delivery_detail = assign(:delivery_detail, stub_model(DeliveryDetail))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
