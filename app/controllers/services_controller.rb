class ServicesController < ApplicationController
  before_action :require_admin

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
   @service = current_user.services.find_by_id(params[:id])
    if @service.present?
      @service.update(service_params)
      redirect_to services_path
    else
      # render :edit
      redirect_to service_path, alert: "you con't update another Admins service."
    end
  end

  def destroy
    @service = current_user.services.find_by_id(params[:id])
    if @service.present?
      @service.delete
      redirect_to services_path
    else
      redirect_to service_path, alert: "you con't delete another Admin service."
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
