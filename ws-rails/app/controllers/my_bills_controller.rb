class MyBillsController < ApplicationController

  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end


end