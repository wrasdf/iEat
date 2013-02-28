class SuccessController < ApplicationController
  def index
    
    respond_to do |format|
      format.html # new.html.erb
      #format.json {}
    end
  end
end