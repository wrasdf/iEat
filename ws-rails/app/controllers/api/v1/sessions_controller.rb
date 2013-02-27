module Api
  module V1
    class SessionsController < Api::V1::BaseController
      include Devise::Controllers::Helpers

      before_filter :ensure_params_exist

      def create
        user = User.find_for_database_authentication(:email => params[:login])
        return invalid_login_attempt unless user

        if user.valid_password?(params[:password])
          sign_in("user", user)
          render :json => {:success => true, :auth_token => user.authentication_token, :email => user.email}
          return
        end
        invalid_login_attempt
      end

      def destroy
        sign_out(resource_name)
      end

      protected
      def ensure_params_exist
        return unless params[:login].blank? and params[:password].blank?
        render :json => {:success => false, :message => "missing user_login parameter"}, :status => 422
      end

      def invalid_login_attempt
        warden.custom_failure!
        render :json => {:success => false, :message => "Error with your login or password"}, :status => 401
      end
    end
  end
end

