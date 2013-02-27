class Api::V1::GroupsController < Api::V1::BaseController
  def active
    respond_with(Group.where('due_date >= ?', Time.now))
  end
end