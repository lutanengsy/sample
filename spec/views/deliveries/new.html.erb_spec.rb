require 'spec_helper'

describe "deliveries/new" do
  before(:each) do
    assign(:delivery, stub_model(Delivery).as_new_record)
  end

  it "renders new delivery form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deliveries_path, "post" do
    end
  end
end
