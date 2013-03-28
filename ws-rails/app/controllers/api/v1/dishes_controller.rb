class Api::V1::DishesController < Api::V1::BaseController
  before_filter

  def detail
    @group = Group.find(params[:id])
    @restaurant = @group.restaurant
    @cuisines = @restaurant.cuisines

    render :file => 'rabl/cuisines'
  end

end