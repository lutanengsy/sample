require 'spec_helper'

describe OrdersController do
  describe 'GET #index' do
    before :each do
      @order = FactoryGirl.create(:order)
    end

    it 'populates with an array of orders' do
      get :index
      assigns(:orders).should eql([@order])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    before :each do
      @order = FactoryGirl.create(:order)
    end

    it "assigns order to @order" do
      get :show, id: @order
      assigns(:order).should eql(@order)
    end

    it "render the #show view" do
      get :show, id: @order
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
  end  

  describe 'GET #edit' do
    it "renders the #edit view" do
      get :edit, id: FactoryGirl.create(:order)
      response.should render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new order" do
        expect {
          post :create, order: FactoryGirl.attributes_for(:order)
        }.to change(Order, :count).by(1)
      end

      it "redirects to new order" do 
        post :create, order: FactoryGirl.attributes_for(:order)
        response.should redirect_to order_path(Order.last)
      end
    end

    context "with invalid attributes" do
      it "does not create a new order" do
        expect {
          post :create, order: FactoryGirl.attributes_for(:invalid_order)
        }.to_not change(Order, :count)
      end

      it "renders the #new method" do
        post :create, order: FactoryGirl.attributes_for(:invalid_order)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @order = FactoryGirl.create(:order, order_date: Date.tomorrow)
    end

    context "with valid attributes" do
      it "finds the requested @order" do
        put :update, id: @order, order: FactoryGirl.attributes_for(:order)
        assigns(:order).should eq(@order)
      end

      it "changes @order details" do
        put :update, id: @order, order: FactoryGirl.attributes_for(:order)
        @order.reload
        @order.order_date.should eq(Date.today)
      end

      it "redirects to updated @order" do
        put :update, id: @order, order: FactoryGirl.attributes_for(:order)
        response.should redirect_to @order
      end
    end

    context "with invalid attributes" do
      it "finds the requested @order" do
        put :update, id: @order, order: FactoryGirl.attributes_for(:order, customer_id: nil)
        assigns(:order).should eq(@order)
      end

      it "does not change @order details" do
        put :update, id: @order, order: FactoryGirl.attributes_for(:order, customer_id: nil)
        @order.reload
        @order.customer_id.should_not eq(nil)
      end

      it "renders the #edit method" do
        put :update, id: @order, order: FactoryGirl.attributes_for(:order, customer_id: nil)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do


    context "has no order details" do
      before :each do
        @order = FactoryGirl.create(:order)
      end

      it "deletes the @order" do
        expect {
          delete :destroy, id: @order
        }.to change(Order, :count).by(-1)
      end

      it "redirects to orders#index" do
        delete :destroy, id: @order
        response.should redirect_to orders_url
      end
    end
  end

  describe "GET #deliver" do
    before :each do
      @order = FactoryGirl.create(:order)
    end

    it "should mark order as delivered" do
      get :deliver, id: @order.id
      response.should redirect_to orders_url
    end
  end

end
