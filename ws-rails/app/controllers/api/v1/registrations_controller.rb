class Api::V1::RegistrationsController < ActionController::Base
  respond_to :json

  def create
    @user = User.create(:name => params[:name],
                        :email => params[:email],
                        :password => params[:password],
                        :telephone => params[:telephone],
                        :password_confirmation => params[:password_confirmation])
    if @user.valid?
      @user.confirm!
      render :file => 'rabl/user'
    else
      respond_with(@user)
    end

  end
end