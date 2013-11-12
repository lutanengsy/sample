require 'spec_helper'

describe "OrderDetails" do
  before :each do
    @detail  = FactoryGirl.create(:order_detail)
    @order   = @detail.order
    @product = @detail.product
  end

  describe "GET order/:order_id/order_details" do
    it "can display order details" do

      visit orders_path

      first(:link, 'Show').click

      current_path.should == "/orders/#{@order.id}"

      page.has_content?(@product.name)
    end
  end

  describe "GET /order/:order_id/order_details/new" do
    it "adds new order detail" do
      visit order_path(@order.id)

      fill_in 'order_detail[quantity]', with: 1
      fill_in 'order_detail[unit]',     with: "boxes"
      select  'Something', from: 'order_detail_product_id'
      fill_in 'order_detail[unit_price]',    with: 10.00
      click_button 'Add'

     current_path.should == "/orders/#{@order.id}"

     page.should have_content "boxes"
     page.should have_content 10.00
    
     page.should have_content "Order detail was successfully created."
    end
  end
  
  describe "GET order/:order_id/order_details/:id" do
    it "edits order detail" do
      visit order_path(@order.id)

      first(:link, 'Edit').click

      current_path.should == "/orders/#{@order.id}/order_details/#{@detail.id}/edit"
 
      fill_in 'order_detail[quantity]', with: 5
      click_button 'Save'

      current_path.should == "/orders/#{@order.id}"
     
      page.should have_content 5

     page.should have_content "Order detail was successfully updated."
    end
  end

  describe "DELETE order/:order_id/order_details/:id" do
    it "can delete order detail" do
      visit order_path(@order.id)

      first(:link, 'Delete').click

      current_path.should == "/orders/#{@order.id}"

     page.should have_content "Order detail was successfully deleted."
    end
  end

end
