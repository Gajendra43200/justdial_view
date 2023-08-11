class ServicesController < ApplicationController
   # before_action :check_admin, except: [:index]
  # before_action :check_customer, only:[:index]
  # before_action :require_login
  # before_action :require_login, only:[:new, :create, :show, :index, :edit, :update, :destroy]
  before_action :require_admin, only:[:new, :create, :edit, :update, :destroy]

  def index
    @services = Service.all
  end
  def show
    @service = Service.find(params[:id])
  end
  def new
    @service = Service.new
  end

  def create
   @service =Service.new(service_params)
   @service.user = current_user
    if@service.save
      redirect_to services_path
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
   @service = @current_user.services.find_by_id(params[:id])
    if @service.update(service_params)
      redirect_to services_path
    else
      render :edit
    end
  end

  def destroy
    @service = @current_user.services.find_by_id(params[:id])
    if@service.delete
      redirect_to services_path
    else
     render :show
    end
  end

  private

  def service_params
    params.require(:service).permit(:service_name, :status ,:location, :city, :user_id)
  end

  def require_admin
    unless current_user.user_type == 'Admin'
      flash[:error] = "you dont have permission  to perform this action"
      redirect_to new_review_path
    end
  end
end
