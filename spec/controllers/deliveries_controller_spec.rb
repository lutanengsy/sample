require 'spec_helper'

describe DeliveriesController do

  describe "GET #index" do
    before :each do
      @delivery = FactoryGirl.create(:delivery)
    end

    it "populates with an array of deliveries" do
      get :index
      assigns(:deliveries).should eql([@delivery])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    before :each do
      @delivery = FactoryGirl.create(:delivery)
    end

    it "assigns delivery to @delivery" do
      get :show, id: @delivery
      assigns(:delivery).should eql(@delivery)    
    end

    it "renders the #show view" do
      get :show, id: @delivery
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
      get :edit, id: FactoryGirl.create(:delivery)
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new delivery entry" do
        expect {
          post :create, delivery: FactoryGirl.attributes_for(:delivery)
        }.to change(Delivery,:count).by(1)
      end

      it "redirect to new delivery" do
        post :create, delivery: FactoryGirl.attributes_for(:delivery)
        response.should redirect_to delivery_path(Delivery.last)
      end
    end
    
    context "with invalid attributes" do
      it "does not create a new delivery" do
        expect {
          post :create, delivery: FactoryGirl.attributes_for(:invalid_delivery)
        }.to_not change(Delivery,:count)
      end

      it "renders the #new method" do
        post :create, delivery: FactoryGirl.attributes_for(:invalid_delivery)
        response.should render_template :new
      end
    end

  end
 
  describe "PUT #update" do
    before :each do
      @delivery = FactoryGirl.create(:delivery, delivery_date: Date.tomorrow)
    end

    context "with valid attributes" do

      it "finds the requested delivery" do
        put :update, id: @delivery, delivery: FactoryGirl.attributes_for(:delivery)
        assigns(:delivery).should eq(@delivery)
      end

      it "changes @delivery details" do
        put :update, id: @delivery, delivery: FactoryGirl.attributes_for(:delivery)
        @delivery.reload
        @delivery.delivery_date.should eq(Date.today)
      end

      it "redirects to updated delivery" do
        put :update, id: @delivery, delivery: FactoryGirl.attributes_for(:delivery)
        response.should redirect_to @delivery
      end
    end

    context "with invalid attributes" do

      it "finds the requested delivery" do
        put :update, id: @delivery, delivery: FactoryGirl.attributes_for(:delivery, delivery_no: nil)
        assigns(:delivery).should eq(@delivery)
      end

      it "does not change @delivery details" do
        put :update, id: @delivery, delivery: FactoryGirl.attributes_for(:delivery, delivery_no: nil)
        @delivery.reload
        @delivery.delivery_no.should_not eq(nil)
        @delivery.delivery_date.should eq(Date.tomorrow)
      end

      it "renders the #edit method" do
        put :update, id: @delivery, delivery: FactoryGirl.attributes_for(:delivery, delivery_no: nil)
        response.should render_template :edit
      end
    end
  end  

  describe "DELETE #destroy" do
    context "allow delete" do

      before :each do
        @delivery = FactoryGirl.create(:delivery)
      end

      it "deletes the delivery entry" do
        expect {
          delete :destroy, id: @delivery
        }.to change(Delivery, :count).by(-1)
      end

      it "redirects to deliveries#index" do
        delete :destroy, id: @delivery
        response.should redirect_to deliveries_url
      end
    end

    context "do not allow delete without details" do
      before :each do
        @detail = FactoryGirl.create(:delivery_detail)
      end

      it "does not delete delivery" do
        expect {
          delete :destroy, id: @detail.delivery_id
        }.to_not change(Delivery, :count)
      end

      it "redirects to deliveries#index" do
          delete :destroy, id: @detail.delivery_id
          response.should redirect_to deliveries_url
      end
    end
  end
end
