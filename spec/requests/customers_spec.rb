require 'spec_helper'

describe "Customers" do
  before :each do
    @customer = FactoryGirl.create(:customer)
  end

  describe "GET /customers" do
    it "Displays all customers" do
      visit customers_path
      page.has_content?("Listing customers")
    end
  end

  describe "GET /customers/new" do

    it "add new customer" do
      visit customers_path

      click_link 'New'
      current_path.should == "/customers/new"

      fill_in "customer_name", :with => "John Doe"
      fill_in "customer_zip", :with => 1234
      click_button "Save"

      current_path.should == "/customers"

      page.has_content?("Customer was successfully created.")
    end
  end

  describe "GET /customers/show" do
    it "can show customer" do
      visit customers_path

      first(:link, 'Show').click
      current_path.should == "/customers/#{@customer.id}"

      page.has_content?(@customer.name)
    end
  end

  describe "GET /customer/:id/edit" do
    it "can edit customer" do
      visit customers_path

      first(:link, 'Edit').click
      current_path.should == "/customers/#{@customer.id}/edit"

      fill_in "customer_name", :with => "Jane Doe"
      click_button "Save"

      current_path.should == "/customers/#{@customer.id}"
      page.has_content?(@customer.name)
    end
  end

  describe "DELETE #destroy" do

    it "can delete customer" do
      visit customers_path
      first(:link, 'Destroy').click

      current_path.should == "/customers"
      page.has_content?("Customer successfully deleted.")      
    end

    it "can not delete customer with order" do
      order = FactoryGirl.create(:order, customer_id: @customer.id)

      visit customers_path
      first(:link, 'Destroy').click

      current_path.should == "/customers"
      page.has_content?("Unable to delete customer.")      
    end

  end

end
