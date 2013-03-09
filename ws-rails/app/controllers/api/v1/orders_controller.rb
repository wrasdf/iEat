require 'oj'

class Api::V1::OrdersController < Api::V1::BaseController
  before_filter

  def create
    group = Group.find(params[:group_id])
    @order = Order.create(:user => current_user, :group => group)

    Oj.load(params[:dishes]).each do |dish|
      OrderDish.create(:order => @order, :dish_id => dish['id'], :quantity => dish['quantity'].to_i)
    end

    render :file => 'rabl/order'

  end
end
