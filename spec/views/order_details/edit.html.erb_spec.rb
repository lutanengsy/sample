require 'spec_helper'

describe "order_details/edit" do
  before(:each) do
    @order_detail = assign(:order_detail, stub_model(OrderDetail))
  end

  it "renders the edit order_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_detail_path(@order_detail), "post" do
    end
  end
end
