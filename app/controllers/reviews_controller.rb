class ReviewsController < ApplicationController
before_action :require_customer, only:[:new, :create, :show, :index, :edit, :update, :destroy]
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
     redirect_to reviews_path
    else
     render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end
  def update
    @review = @current_user.reviews.find(params[:id])
    if @review.nil?
      redirect_to reviews_path
    else
      @review.update(review_params)
      redirect_to reviews_path
    end
  end

  def destroy
    @review = @current_user.reviews.find_by_id(params[:id])
    if @review.present?
      @review.delete
      redirect_to reviews_path, notice: "Review deleted successfully."
    else
      redirect_to reviews_path, alert: "you con't delete another users's review."
    end
  end

  def location_service_name
    # byebug
    if  params[:service_name].present?
      @services = Service.where("service_name like ?" ,"%#{params[:service_name]}%")
      # redirect_to reviews_path
      render 'service_name_print'
    elsif params[:city].present?
      @services = Service.where("city like ?" ,"%#{params[:city]}%")
       if @services.present?
        render 'reviews/service_name_print'
      end
    elsif current_user.present?
      @services = Service.where(location: @current_user.location)
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
    # params.require(:review).permit(:content, :rating, :service_id)
    params.require(:review).permit(:content, :rating, :service_id)

  end
end


# <td><%= link_to "Show", review %></td>
#         <td><%= link_to "Edit", edit_review_path(review)%></td>
#         <td><%= button_to "Destroy", review, method: :delete%></td>
