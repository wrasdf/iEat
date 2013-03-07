class Api::V1::OrderController < Api::V1::BaseController
  before_filter

  def create
    group = Group.find(params[:group_id])
    order = Order.create(:user => current_user, :group => group,
    )

    if order.valid?
      respond_with(order, :location => api_v1_group_order_path(group, order))
    else
      respond_with(order)
    end
  end
end