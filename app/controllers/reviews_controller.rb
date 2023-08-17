class ReviewsController < ApplicationController
before_action :require_customer
def index
    @reviews= Review.all
  end
  def new
    if params[:service_id]
      @service = Service.find(params[:service_id])
      @review = @service.reviews.new
    else
      @services = Service.all
    end
    @review = Review.new
  end

   def show
    @review = Review.find(params[:id])
  end

  def create
    @service = Service.find(params[:review][:service_id])
    @review = @service.reviews.new(review_params)
    @review.user = current_user
    if @review.save
     redirect_to reviews_path,notice: "Review Creted successfully."
    else
     render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end
  def update
    @review = current_user.reviews.find_by_id(params[:id])

    if @review.present?
      @review.update(review_params)
      redirect_to reviews_path,notice: "Review updated successfully."
    else
      redirect_to reviews_path, notice: "you con't update another users's review."
    end
  end

  def destroy
    @review = current_user.reviews.find_by_id(params[:id])
    if @review.present?
      @review.delete
      redirect_to reviews_path, notice: "Review deleted successfully."
    else
      redirect_to reviews_path, alert: "you con't delete another users's review."
    end
  end

  def location_service_name
    if  params[:service_name].present?
      @services = Service.where("service_name like ?" ,"%#{params[:service_name]}%")
      if @services.present?
      render 'service_name_print'
    else
      redirect_to reviews_path, notice: "Service Not Exits "
    end
    elsif params[:city].present?
      @services = Service.where("city like ?" ,"%#{params[:city]}%")
      if @services.present?
        render 'reviews/service_name_print'
      else
        redirect_to reviews_path ,notice: "Service Not Exits For This City"
      end
    elsif current_user.present?
      @services = Service.where(location: current_user.location)
      if @services.present?
        render 'service_name_print'
      else
        services = Service.all
        redirect_to services_path
      end
    end
  end

  private
  def require_customer
    unless current_user.user_type == 'Customer'
      flash[:error] = "you dont have permission  to perform this action"
    end
  end
  def review_params
    params.require(:review).permit(:content, :rating, :service_id)

  end
end
