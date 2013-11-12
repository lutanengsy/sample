require 'spec_helper'

describe "deliveries/show" do
  before(:each) do
    @delivery = assign(:delivery, stub_model(Delivery))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
