require "spec_helper"

describe RestaurantsController do
  describe "routing" do

    it "routes to #index" do
      get("/restaurants").should route_to("restaurants#index")
    end

    it "routes to #new" do
      get("/restaurants/new").should route_to("restaurants#new")
    end

    it "routes to #show" do
      get("/restaurants/1").should route_to("restaurants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/restaurants/1/edit").should route_to("restaurants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/restaurants").should route_to("restaurants#create")
    end

    it "routes to #update" do
      put("/restaurants/1").should route_to("restaurants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/restaurants/1").should route_to("restaurants#destroy", :id => "1")
    end

  end
end
