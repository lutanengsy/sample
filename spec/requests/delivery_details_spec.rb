require 'spec_helper'

describe "DeliveryDetails" do
  before :each do
    @detail   = FactoryGirl.create(:delivery_detail)
    @delivery = @detail.delivery
    @product  = @detail.product
  end

  describe "GET delivery/:delivery_id/delivery_details" do
    it "can display delivery details" do

      visit deliveries_path

      first(:link, 'Show').click

      current_path.should == "/deliveries/#{@delivery.id}"

      page.has_content?(@product.name)
    end
  end

  describe "GET /delivery/:delivery_id/delivery_details/new" do
    it "adds new delivery detail" do
      visit delivery_path(@delivery.id)

      fill_in 'delivery_detail[quantity]', with: 1
      fill_in 'delivery_detail[unit]',     with: "boxes"
      select  'Something', from: 'delivery_detail[product_id]'
      fill_in 'delivery_detail[price]',    with: 10.00
      click_button 'Add'

     current_path.should == "/deliveries/#{@delivery.id}"

     page.should have_content "boxes"
     page.should have_content 10.00
    
     page.should have_content "Delivery detail was successfully created."

    end
  end
  
  describe "GET delivery/:delivery_id/delivery_details/:id" do
    it "edits delivery detail" do
      visit delivery_path(@delivery.id)

      first(:link, 'Edit').click

      current_path.should == "/deliveries/#{@delivery.id}/delivery_details/#{@detail.id}/edit"
 
      fill_in 'delivery_detail[quantity]', with: 5
      click_button 'Save'

      current_path.should == "/deliveries/#{@delivery.id}"
     
      page.should have_content 5

     page.should have_content "Delivery detail was successfully updated."
    end
  end

  describe "DELETE delivery/:delivery_id/delivery_details/:id" do
    it "can delete delivery detail" do
      visit delivery_path(@delivery.id)

      first(:link, 'Delete').click

      current_path.should == "/deliveries/#{@delivery.id}"

     page.should have_content "Delivery detail was successfully deleted."
    end
  end

end
