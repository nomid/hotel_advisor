class HotelsController < ApplicationController
  before_action :check_auth, only: [:new, :myhotels, :edit, :update, :destroy]
  def new
    @hotel = Hotel.new
    @hotel.adress = Adress.new
  end  

  def show
    @hotel = Hotel.find(params[:format])
    @comments = @hotel.comments
    @comment = Comment.new
  end

  def create
    @hotel = current_user.hotels.build(hotels_params)
    @hotel.adress = Adress.new(adress_params)
    if @hotel.save 
      flash[:success] = "Hotel created"
      redirect_to myhotels_hotel_path 
    else
      flash.now[:alert] = "Fill required fields"
      render 'new'
    end
  end

  def myhotels
    @hotels = current_user.hotels.paginate(page:params[:page])
  end

  def edit
    if current_user.hotels.exists?(params[:format])
      @hotel = current_user.hotels.find(params[:format])
    else 
      flash[:alert] = 'Not accessed'
      redirect_to root_path
    end
  end

  def update
    if current_user.hotels.exists?(params[:hotel][:id])
      @hotel = current_user.hotels.find(params[:hotel][:id])
      if @hotel.update_attributes(hotels_params) && @hotel.adress.update_attributes(adress_params)
            flash[:success] = "Hotel updated"
            redirect_to myhotels_hotel_path
        else
          flash[:alert] = "Error validation"
          render 'edit'
        end
    else
      flash[:alert] = 'Not accessed'
      redirect_to root_path
    end
  end

  def destroy
    if current_user.hotels.exists?(params[:format])
      hotel = current_user.hotels.find(params[:format])
      hotel.destroy
      flash[:success] = "Hotel deleted."
      redirect_to myhotels_hotel_path
    else
      flash[:alert] = 'Not accessed'
      redirect_to root_path
    end
  end

  private
    def hotels_params
      params.require(:hotel).permit(:title, :breackfest, :room_desc,
                                      :price, :star_rating, :photo)
    end

    def adress_params
      permitted = params.permit(hotel: [ adress_attributes: [:country, :state, :city, :street]])
      permitted[:hotel][:adress_attributes]
    end

    def check_auth
      unless signed_in?
        flash[:notice] = 'Please Sign in'
        redirect_to new_user_session_path
      end
    end
end
