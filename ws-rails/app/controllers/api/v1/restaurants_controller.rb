class Api::V1::RestaurantsController < Api::V1::BaseController
  def list
    @restaurants = Restaurant.all
    render :file => 'rabl/restaurants'
  end
end