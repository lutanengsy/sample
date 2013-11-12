require 'spec_helper'

describe "Orders" do
  before :each do
    @customer = FactoryGirl.create(:customer)
  end

  describe "GET /orders" do
    it "Displays all orders" do
      visit orders_path
      page.has_content?("Listing orders")
    end
  end

  describe "GET /orders/new" do

    it "add new order" do
      visit orders_path

      click_link 'New Order'
      current_path.should == "/orders/new"

      select 'John Doe', from: 'order_customer_id'
      click_button "Save"

      current_path.should == "/orders/#{Order.last.id}"

      page.has_content?("Order was successfully created.")
    end
  end

  describe "GET /orders/show" do

    it "can show order" do
      order = FactoryGirl.create(:order_without_customer, customer_id: @customer.id)

      visit orders_path

      first(:link, 'Show').click
      current_path.should == "/orders/#{order.id}"

      page.has_content?(order.customer)
    end
  end

  describe "GET /order/:id/edit" do

    it "can edit order" do
      order = FactoryGirl.create(:order_without_customer, customer_id: Customer.first.id)

      visit orders_path

      click_link 'Edit'

      current_path.should == "/orders/#{order.id}/edit"

      select 'John Doe', from: 'order_customer_id'
      click_button "Save"

      current_path.should == "/orders/#{order.id}"
      page.has_content?(order.customer)
      page.has_content?("Order was successfully updated.")
    end
  end

  describe "DELETE #destroy" do

    it "can delete order" do
      order = FactoryGirl.create(:order_without_customer, customer_id: Customer.first.id)

      visit orders_path
      first(:link, 'Destroy').click

      current_path.should == "/orders"
      page.has_content?("Order successfully deleted.")      
    end

  end
end
