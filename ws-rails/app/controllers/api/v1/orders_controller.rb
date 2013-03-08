class Api::V1::OrdersController < Api::V1::BaseController
  before_filter

  def create
    group = Group.find(params[:group_id])
    order = Order.create(:user => current_user, :group => group)


    puts "asdbf"
    params[:dishes].each do |x|
      puts x
    end
    #OrderDish.create()

    puts 'hereeeeeeeeeeeeeehereeeeeeeeeeeeeehereeeeeeeeeeeeeehereeeeeeeeeeeeeehereeeeeeeeeeeeeehereeeeeeeeeeeeee'
    if order.valid?
      #respond_with(order, :location => api_v1_group_order_path(group, order))
    else

      respond_with(order)
    end
  end
end