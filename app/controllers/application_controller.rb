class ApplicationController < ActionController::Base
   # before_action :require_login
  helper_method :current_user

    private

  def current_user
    # @current_user ||= session[:current_user_id] &&
    # User.find_by(id: session[:current_user_id])
    @current_user ||= User.find_by(id: session[:user_id])
  end

    def require_login
      # allows only logged in user
    if @current_user.nil?
      redirect_to signin_users_path
    end
    end
end
