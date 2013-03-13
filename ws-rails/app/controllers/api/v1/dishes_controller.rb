class Api::V1::DishesController < Api::V1::BaseController
  before_filter

  def detail
    @group = Group.find(params[:id])
    @cuisines = @group.restaurant.restaurant_cuisines.map { |rc| rc.cuisine}
    render :file => 'rabl/cuisines.rabl'
  end

end