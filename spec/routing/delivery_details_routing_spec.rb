require "spec_helper"

describe DeliveryDetailsController do
  describe "routing" do

    it "routes to #index" do
      #get("/delivery_details").should route_to("delivery_details#index")
    end

    it "routes to #new" do
      #get("/delivery_details/new").should route_to("delivery_details#new")
    end

    it "routes to #show" do
      #get("/delivery_details/1").should route_to("delivery_details#show", :id => "1")
    end

    it "routes to #edit" do
      #get("/delivery_details/1/edit").should route_to("delivery_details#edit", :id => "1")
    end

    it "routes to #create" do
      #post("/delivery_details").should route_to("delivery_details#create")
    end

    it "routes to #update" do
      #put("/delivery_details/1").should route_to("delivery_details#update", :id => "1")
    end

    it "routes to #destroy" do
      #delete("/delivery_details/1").should route_to("delivery_details#destroy", :id => "1")
    end

  end
end
