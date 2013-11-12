require 'spec_helper'

describe "Products" do
  before :each do
    @product = FactoryGirl.create(:product)
  end

  describe "GET /products" do
    it "Displays all products" do
      visit products_path
      page.has_content?("Listing products")
    end
  end

  describe "GET /products/new" do

    it "add new product" do
      visit products_path

      click_link 'New'
      current_path.should == "/products/new"

      fill_in "product_name", :with => "Oranges"
      click_button "Save"

      current_path.should == "/products/#{Product.last.id}"

      page.has_content?("Product was successfully created.")
    end
  end

  describe "GET /products/show" do
    it "can show product" do
      visit products_path

      first(:link, 'Show').click
      current_path.should == "/products/#{@product.id}"

      page.has_content?(@product.name)
    end
  end

  describe "GET /product/:id/edit" do
    it "can edit product" do
      visit products_path

      first(:link, 'Edit').click
      current_path.should == "/products/#{@product.id}/edit"

      fill_in "product_name", :with => "Jane Doe"
      click_button "Save"

      current_path.should == "/products/#{@product.id}"
      page.has_content?(@product.name)
    end
  end

  describe "DELETE #destroy" do
    it "can delete product" do
      visit products_path
      first(:link, 'Destroy').click

      current_path.should == "/products"
      page.has_content?("Product successfully deleted.")      
    end

    it "can not delete product with delivery details" do
      detail = FactoryGirl.create(:delivery_detail, product_id: Product.first.id)

      visit products_path
      first(:link, 'Destroy').click

      current_path.should == "/products"
      page.has_content?("Unable to delete product.")      
    end

    it "can not delete product with order details" do
      detail = FactoryGirl.create(:order_detail, product_id: Product.first.id)

      visit products_path
      first(:link, 'Destroy').click

      current_path.should == "/products"
      page.has_content?("Unable to delete product.")      
    end
  end

end
