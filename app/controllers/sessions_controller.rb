class SessionsController < ApplicationController
  def  new
    #render login form
  end
  def create
    user = User.find_by_email(params[:email])
    # if user && user.authenticate(params[:password])
    if user.password == params[:password]
      session[:user_id] = user.id
      redirect_to new_service_path, notice: 'Loggded in successfully'
    else
      flash.now[:error] = ' Invaild email or password_digest'
      render :new
    end
  end
   def destroy
    session.delete(:user_id)
    current_user=nil?
    redirect_to login_path, notice: 'Loggout successfully '
  end

  private

  def require_admin
    unless current_user&.admin?
      flash[:error]= 'you must be an admin to perform this action'
      redirect_to root_path
    end
   end
   def require_admin
    unless current_user&.customer?
      flash[:error]= 'you must be an admin to perform this action'
      redirect_to root_path
    end
   end
end
