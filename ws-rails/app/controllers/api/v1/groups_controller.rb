class Api::V1::GroupsController < Api::V1::BaseController
  before_filter

  def mine
    @myGroups = Group.where('user_id = ?', current_user.id)

    render :file => 'groups/list'
  end

  def active
    respond_with(Group.where('due_date >= ?', Time.now))
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

  def list
    @myGroups = Group.where('user_id = ?', current_user.id)
    @activeGroups = Group.where('due_date >= ? and user_id <> ?', Time.now, current_user.id)

    render :file => 'groups/list'
  end
end