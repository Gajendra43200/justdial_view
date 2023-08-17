class SessionsController < ApplicationController
  def  new
    #render login form
  end
  def create
    @user = User.find_by_email(params[:email])
    # if user && user.authenticate(params[:password])
    if @user.present?
      if @user.password == params[:password]
        session[:user_id] = @user.id
        redirect_to new_service_path, notice: 'Loggded in successfully'
      end
    else
      flash.now[:error] =  "Invaild email or password_digest"
      # render :new, aler: "you con't update another Admins service."
    end
  end
   def destroy
    session.delete(:user_id)
    current_user=nil?
    redirect_to login_path, notice: 'Loggout successfully '
  end
end
