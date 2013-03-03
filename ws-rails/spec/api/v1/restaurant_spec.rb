require 'spec_helper'

describe "/api/v1/restaurants" do
  let(:user) {
    @user = FactoryGirl.create(:user)
    puts @user
    sign_in(@user)
  }

  let(:token) { @user.authentication_token }

  before do
    @restaurant = FactoryGirl.create(:restaurant)
    #@user.permissions.create!(:action => "view", :thing => @restaurant)
  end

  context "restaurants viewable by this user" do
    #let(:url) { "/api/v1/restaurants" }

    it "json" do
      get "/api/v1/restaurants"

      restaurants_json = Restaurant.for(user).all.to_json
      last_response.body.should eql(restaurants_json)
      last_response.status.should eql(200)
      restaurants = JSON.parse(last_response.body)
      restaurants.any? do |r|
        r["name"] == "restaurant_name"
      end.should be_true
    end
  end

end




