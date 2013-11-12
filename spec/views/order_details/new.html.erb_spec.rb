require 'spec_helper'

describe "order_details/new" do
  before(:each) do
    assign(:order_detail, stub_model(OrderDetail).as_new_record)
  end

  it "renders new order_detail form" do
    # render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # assert_select "form[action=?][method=?]", order_details_path, "post" do
    # end
  end
end
