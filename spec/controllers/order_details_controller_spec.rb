require 'spec_helper'

describe OrderDetailsController do

  describe "GET #edit" do
    it "renders the #edit view" do
      detail = FactoryGirl.create(:order_detail)

      get :edit, id: detail.id, order_id: detail.order_id
      response.should render_template :edit  
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before :each do
        @order = FactoryGirl.create(:order)
        @product = FactoryGirl.create(:product)
      end 

      it "creates a new detail entry" do
        expect {
          post :create, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail, product_id: @product.id)
        }.to change(OrderDetail, :count).by(1)
      end

      it "redirects to order #show" do
        post :create, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail, product_id: @product.id)
        response.should redirect_to order_path(@order.id)
      end
    end

    context "with invalid attributes" do
      before :each do
        @order = FactoryGirl.create(:order)
      end 

      it "does not create a new detail entry" do
        expect {
          post :create, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail)
        }.to_not change(OrderDetail, :count)
      end

      it "renders order #show page" do
        post :create, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail)
        response.should render_template 'orders/show'
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @detail = FactoryGirl.create(:order_detail, quantity: 5)
      @order  = @detail.order
    end 

    context "with valid attributes" do
      it "find the requested detail" do
        put :update, id: @detail.id, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail)
        assigns(:order_detail).should eq(@detail)
      end

      it "updates the requested detail" do
	put :update, id: @detail.id, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail)
        @detail.reload
        @detail.quantity.should_not eq(5)
      end

      it "redirects to order#show page" do
        put :update, id: @detail.id, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail)
        response.should redirect_to @order
      end
    end
   
    context "with invalid attributes" do
      it "finds the requested detail" do
        put :update, id: @detail.id, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail, quantity: nil)
        assigns(:order_detail).should eq(@detail)
      end

      it "does not change the order detail" do
        put :update, id: @detail.id, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail, quantity: nil)
        @detail.reload
        @detail.quantity.should_not eq(nil)
      end

      it "renders order_details #edit page" do
        put :update, id: @detail.id, order_id: @order.id, order_detail: FactoryGirl.attributes_for(:order_detail, quantity: nil)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @detail = FactoryGirl.create(:order_detail)
      @order  = @detail.order
    end 

    context "allow delete" do
      it "deletes the order detail" do
        expect {
          delete :destroy, order_id: @order.id, id: @detail.id
        }.to change(OrderDetail, :count).by(-1)
      end

      it "redirects to orders#index" do
        delete :destroy, order_id: @order.id, id: @detail.id
        response.should redirect_to order_path(@order)
      end
    end

  end 

end
