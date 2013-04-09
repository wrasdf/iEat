require 'oj'

class Api::V1::OrdersController < Api::V1::BaseController
  before_filter

  def create
    group = Group.find(params[:group_id])

    if group.due_date > Time.current

      @order = Order.create(:user => current_user, :group => group)

      Oj.load(params[:dishes]).each do |dish|
        OrderDish.create(:order => @order, :dish_id => dish['id'], :quantity => dish['quantity'].to_i)
      end

      render :file => 'rabl/order'

    else

      render :json => {:status =>'out_of_dueDate'}.to_json, :status => 200

    end


  end

  def list
    @unpaid_orders = Order.all.select{|order| order.user != @current_user && order.group.user == @current_user && order.paid != true}
    @payback_orders = Order.all.select{|order| order.user == @current_user && order.group.user != @current_user && order.paid != true}
    render :file => 'rabl/order-list'
  end

  def paid
    order = Order.find(params[:id])
    order.paid = true
    order.save!()
    respond_with(order)
  end

  def delete
    order = Order.find(params[:id])
    order.delete
    respond_to do |format|
      format.json{
        render :json => {:status =>'success'}.to_json, :status => 200
      }
    end
  end


end