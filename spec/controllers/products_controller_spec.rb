require 'spec_helper'

describe ProductsController do

  describe "GET #index" do
    it "populates with an array of products" do
      product = FactoryGirl.create(:product)
      get :index
      assigns(:products).should eql([product])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns product to @product" do
      product = FactoryGirl.create(:product)
      get :show, id: product
      assigns(:product).should eql(product)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:product)
      response.should render_template :show
    end
  end
  
  describe "GET #new" do
    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "renders the #edit view" do
      get :edit, id: FactoryGirl.create(:product)
      response.should render_template :edit
    end
  end


  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new product" do
        expect {
          post :create, product: FactoryGirl.attributes_for(:product)
        }.to change(Product,:count).by(1)
      end
      
      it "redirect to the new product" do
        post :create, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to Product.last
      end 
    end
 
    context "with invalid attributes" do
      it "does not create a new product" do
        expect {
          post :create, product: FactoryGirl.attributes_for(:invalid_product)
        }.to_not change(Product,:count)
      end

      it "renders the #new method" do
        post :create, product: FactoryGirl.attributes_for(:invalid_product)
        response.should render_template :new
      end
    end
  end
  
  describe "PUT #update" do
    before :each do
      @product = FactoryGirl.create(:product, name: "Something else")
    end

    context "with valid attributes" do
      it "finds the requested @product" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        assigns(:product).should eq(@product)
      end
 
      it "changes @product details" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        @product.reload
        @product.name.should eq("Something")
      end

      it "redirects to the updated @product" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to @product
      end
    end

    context "with invalid attributes" do
      it "finds the requested @product" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        assigns(:product).should eq(@product)
      end

      it "does not change @product details" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, name: nil)
        @product.reload
        @product.name.should_not eq(nil)
        @product.name.should eq("Something else")
      end

      it "renders the #edit method" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, name: nil)
        response.should render_template :edit
      end
    end
  end

   describe 'DELETE #destroy' do

    context "allow delete" do 

      before :each do
        @product = FactoryGirl.create(:product)
      end

      it "deletes the product" do
        expect {
          delete :destroy, id: @product
        }.to change(Product, :count).by(-1)
      end

      it "redirects to product#index" do
        delete :destroy, id: @product
        response.should redirect_to products_url
      end
    end

    context "do not allow delete if with order detail" do
      before :each do
        @order_detail = FactoryGirl.create(:order_detail)
      end

      it "does not delete the product" do
        expect {
          delete :destroy, id: @order_detail.product_id
        }.to_not change(Product,:count)
      end

      it "redirects to products#index" do
        delete :destroy, id: @order_detail.product_id
        response.should redirect_to products_url
      end
    end
    
    context "do not allow delete if with delivery detail" do
      before :each do
        @delivery_detail = FactoryGirl.create(:delivery_detail)
      end

      it "does not delete the product" do
        expect {
          delete :destroy, id: @delivery_detail.product_id
        }.to_not change(Product,:count)
      end

      it "redirects to products#index" do
        delete :destroy, id: @delivery_detail.product_id
        response.should redirect_to products_url
      end
    end

  end
end
