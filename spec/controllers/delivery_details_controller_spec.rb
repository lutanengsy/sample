require 'spec_helper'

describe DeliveryDetailsController do

  describe "GET #edit" do
    it "renders the #edit view" do
      detail = FactoryGirl.create(:delivery_detail)

      get :edit, id: detail.id, delivery_id: detail.delivery_id
      response.should render_template :edit  
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before :each do
        @delivery = FactoryGirl.create(:delivery)
        @product = FactoryGirl.create(:product)
      end 

      it "creates a new detail entry" do
        expect {
          post :create, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail, product_id: @product.id)
        }.to change(DeliveryDetail, :count).by(1)
      end

      it "updates product balance" do
        @product.balance.should == 0

        post :create, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail, product_id: @product.id, quantity: 5)

        @product.reload
        @product.balance.should == 5
      end

      it "adds inventory entry" do
        expect {
          post :create, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail, product_id: @product.id, quantity: 5)
        }.to change(Inventory, :count).by(1)
      end

      it "redirects to delivery #show" do
        post :create, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail, product_id: @product.id)
        response.should redirect_to delivery_path(@delivery.id)
      end
    end

    context "with invalid attributes" do
      before :each do
        @delivery = FactoryGirl.create(:delivery)
      end 

      it "does not create a new detail entry" do
        expect {
          post :create, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail)
        }.to_not change(DeliveryDetail, :count)
      end

      it "does not change product balance"
      it "does not add an inventory entry"

      it "renders order #show page" do
        post :create, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail)
        response.should render_template 'deliveries/show'
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @detail   = FactoryGirl.create(:delivery_detail, quantity: 5)
      @delivery = @detail.delivery
    end 

    context "with valid attributes" do
      it "find the requested detail" do
        put :update, id: @detail.id, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail)
        assigns(:delivery_detail).should eq(@detail)
      end

      it "updates the requested detail" do
	put :update, id: @detail.id, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail)
        @detail.reload
        @detail.quantity.should_not eq(5)
      end

      it "redirects to delivery#show page" do
        put :update, id: @detail.id, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail)
        response.should redirect_to @delivery
      end
    end
   
    context "with invalid attributes" do
      it "finds the requested detail" do
        put :update, id: @detail.id, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail, quantity: nil)
        assigns(:delivery_detail).should eq(@detail)
      end

      it "does not change the delivery detail" do
        put :update, id: @detail.id, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail, quantity: nil)
        @detail.reload
        @detail.quantity.should_not eq(nil)
      end

      it "renders delivery_details #edit page" do
        put :update, id: @detail.id, delivery_id: @delivery.id, delivery_detail: FactoryGirl.attributes_for(:delivery_detail, quantity: nil)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @product  = FactoryGirl.create(:product)
      @detail   = FactoryGirl.create(:delivery_detail, product_id: @product.id, quantity: 5)
      @delivery = @detail.delivery
    end 

    it "deletes the delivery detail" do
      expect {
        delete :destroy, delivery_id: @delivery.id, id: @detail.id
      }.to change(DeliveryDetail, :count).by(-1)
    end

    it "updates product balance" do
      @product.balance.should == 5

      delete :destroy, delivery_id: @delivery.id, id: @detail.id
     
      @product.reload
      @product.balance.should == 0
    end

    it "removes inventory entry" do
      expect {
        delete :destroy, delivery_id: @delivery.id, id: @detail.id
      }.to change(Inventory, :count).by(-1)
    end

    it "redirects to delivery#index" do
      delete :destroy, delivery_id: @delivery.id, id: @detail.id
      response.should redirect_to delivery_path(@delivery)
    end

  end 

end
