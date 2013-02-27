class Api::V1::GroupsController < Api::V1::BaseController
  before_filter
  def active
    respond_with(Group.where('due_date >= ?', Time.now))
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    group = Group.new(:user => current_user,
                     :restaurant => restaurant).save!
    respond_with(Group.all, :status => 201)
  end
end