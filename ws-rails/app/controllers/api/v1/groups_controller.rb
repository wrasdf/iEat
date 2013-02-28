class Api::V1::GroupsController < Api::V1::BaseController
  before_filter

  def active
    respond_with(Group.where('due_date >= ?', Time.now))
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    group = Group.create(:user => current_user, :restaurant => restaurant)
    if group.valid?
      respond_with(group, :location => api_v1_group_path(group))
    else
      respond_with(group)
    end
  end
end