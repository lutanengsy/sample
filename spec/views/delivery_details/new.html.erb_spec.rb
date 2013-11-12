require 'spec_helper'

describe "delivery_details/new" do
  before(:each) do
    assign(:delivery_detail, stub_model(DeliveryDetail).as_new_record)
  end

  it "renders new delivery_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", delivery_details_path, "post" do
    end
  end
end
