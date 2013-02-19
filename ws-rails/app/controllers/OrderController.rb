class OrderController < ApplicationController
  def my_orders
    render :file => "resources/groupOrders.json", :content_type => 'application/json'
  end
end
