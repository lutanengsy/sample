require 'spec_helper'

describe CustomersController do

  describe "GET #index" do
    it "populates with an array of customers" do
      customer = FactoryGirl.create(:customer)
      get :index
      assigns(:customers).should eql([customer])
    end

    it "renders the #index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns customer to @customer" do
      customer = FactoryGirl.create(:customer)
      get :show, id: customer
      assigns(:customer).should eql(customer)
    end

    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:customer)
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
      get :edit, id: FactoryGirl.create(:customer)
      response.should render_template :edit
    end
  end


  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new customer" do
        expect {
          post :create, customer: FactoryGirl.attributes_for(:customer)
        }.to change(Customer,:count).by(1)
      end
      
      it "redirect to the new customer" do
        post :create, customer: FactoryGirl.attributes_for(:customer)
        response.should redirect_to Customer.last
      end 
    end
 
    context "with invalid attributes" do
      it "does not create a new customer" do
        expect {
          post :create, customer: FactoryGirl.attributes_for(:invalid_customer)
        }.to_not change(Customer,:count)
      end

      it "renders the #new method" do
        post :create, customer: FactoryGirl.attributes_for(:invalid_customer)
        response.should render_template :new
      end
    end
  end
  
  describe "PUT #update" do
    before :each do
      @customer = FactoryGirl.create(:customer, name: "Jane Doe")
    end

    context "with valid attributes" do
      it "finds the requested @customer" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer)
        assigns(:customer).should eq(@customer)
      end
 
      it "changes @customer details" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer)
        @customer.reload
        @customer.name.should eq("John Doe")
      end

      it "redirects to the updated @customer" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer)
        response.should redirect_to @customer
      end
    end

    context "with invalid attributes" do
      it "finds the requested @customer" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer)
        assigns(:customer).should eq(@customer)
      end

      it "does not change @customer details" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer, name: nil)
        @customer.reload
        @customer.name.should_not eq(nil)
        @customer.name.should eq("Jane Doe")
      end

      it "renders the #edit method" do
        put :update, id: @customer, customer: FactoryGirl.attributes_for(:customer, name: nil)
        response.should render_template :edit
      end
    end
  end

   describe 'DELETE #destroy' do

    context "allow delete" do 

      before :each do
        @customer = FactoryGirl.create(:customer)
      end

      it "deletes the customer" do
        expect {
          delete :destroy, id: @customer
        }.to change(Customer, :count).by(-1)
      end

      it "redirects to customer#index" do
        delete :destroy, id: @customer
        response.should redirect_to customers_url
      end
    end

    context "do not allow if has order" do

      before :each do
        @order_detail = FactoryGirl.create(:order_detail)
      end
    
      it "will not delete the customer" do
        expect {
          delete :destroy, id: @order_detail.order.customer_id
        }.to_not change(Customer,:count)

      end

      it "redirects to customer#index" do
        delete :destroy, id: @order_detail.order.customer_id
        response.should redirect_to customers_url
      end
    end
  end
end
