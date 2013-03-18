class Api::V1::GroupsController < Api::V1::BaseController
  before_filter

  def active
    @active_groups = Group.where('due_date >= ?', Time.now).order("due_date DESC")
    render :file => 'rabl/active_groups'
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    group = Group.create(:user => current_user, :restaurant => restaurant, :name => params[:name], :due_date => params[:due_date])
    if group.valid?
      respond_with(group, :location => api_v1_group_path(group))
    else
      respond_with(group)
    end
  end

  def detail
    @group = Group.find(params[:id])

    puts @group.orders[0].user.email
    render :file => 'rabl/detail'
  end
end