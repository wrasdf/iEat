class ApiController < ApplicationController
  def my_order
    render :file => 'resources/myOrder.json', :content_type => 'application/json'
  end

  def group_orders
    render :file => 'resources/groupOrders.json', :content_type => 'application/json'
  end

  def active_groups
    render :file => 'resources/activeGroupList.json', :content_type => 'application/json'
  end
end
