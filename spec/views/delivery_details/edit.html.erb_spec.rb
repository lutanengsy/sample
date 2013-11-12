require 'spec_helper'

describe "delivery_details/edit" do
  before(:each) do
    @delivery_detail = assign(:delivery_detail, stub_model(DeliveryDetail))
  end

  it "renders the edit delivery_detail form" do
    # render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # assert_select "form[action=?][method=?]", delivery_detail_path(@delivery_detail), "post" do
    # end
  end
end
