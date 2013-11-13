require 'spec_helper'

describe "Deliveries" do
  before :each do
    @delivery = FactoryGirl.create(:delivery)
  end

  describe "GET /deliveries" do
    it "Displays all deliveries" do
      visit deliveries_path
      page.has_content?("Listing deliveries")
    end
  end

  describe "GET /deliveries/new" do

    it "add new delivery" do
      visit deliveries_path

      click_link 'New'
      current_path.should == "/deliveries/new"

      fill_in "delivery_delivery_no", :with => "DR123"
      click_button "Save"

      current_path.should == "/deliveries/#{Delivery.last.id}"

      page.has_content?("Delivery was successfully created.")
    end
  end

  describe "GET /deliveries/show" do
    it "can show delivery" do
      visit deliveries_path

      first(:link, 'Show').click
      current_path.should == "/deliveries/#{@delivery.id}"

      page.has_content?(@delivery.delivery_no)
    end
  end

  describe "GET /delivery/:id/edit" do
    it "can edit delivery" do
      visit deliveries_path

      first(:link, 'Edit').click
      current_path.should == "/deliveries/#{@delivery.id}/edit"

      fill_in "delivery_delivery_no", :with => "DR234"
      click_button "Save"

      current_path.should == "/deliveries/#{@delivery.id}"
      page.has_content?(@delivery.delivery_no)
    end
  end

  describe "DELETE #destroy" do

    it "can delete delivery" do
      visit deliveries_path
      first(:link, 'Destroy').click

      current_path.should == "/deliveries"
      page.has_content?("Delivery successfully deleted.")      
    end

    it "can not delete delivery with delivery detail" do
      detail   = FactoryGirl.create(:delivery_detail)
      delivery = detail.delivery

      visit deliveries_path
      first(:link, 'Destroy').click

      current_path.should == "/deliveries"
      page.has_content?("Unable to delete delivery.")
    end

  end

end
