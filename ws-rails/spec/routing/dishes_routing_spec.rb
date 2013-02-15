require "spec_helper"

describe DishesController do
  describe "routing" do

    it "routes to #index" do
      get("/dishes").should route_to("dishes#index")
    end

    it "routes to #new" do
      get("/dishes/new").should route_to("dishes#new")
    end

    it "routes to #show" do
      get("/dishes/1").should route_to("dishes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dishes/1/edit").should route_to("dishes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dishes").should route_to("dishes#create")
    end

    it "routes to #update" do
      put("/dishes/1").should route_to("dishes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dishes/1").should route_to("dishes#destroy", :id => "1")
    end

  end
end
