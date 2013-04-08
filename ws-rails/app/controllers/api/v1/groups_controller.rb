class Api::V1::GroupsController < Api::V1::BaseController
  before_filter

  def active
    @active_groups = Group.where('due_date >= ?', Time.zone.today).order("due_date DESC")
    render :file => 'rabl/active_groups'
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    @group = Group.create(:user => current_user, :restaurant => restaurant, :name => params[:name], :due_date => Time.parse(params[:due_date]).getutc)
    if @group.valid?
      #UserMailer.send.deliver
      render :file => 'rabl/group'
    else
      respond_with(@group)
    end
  end

  def detail
    @group = Group.find(params[:id])
    render :file => 'rabl/detail'
  end
end