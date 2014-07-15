class HotelsController < ApplicationController
  def new
    @hotel = Hotel.new
  end  

  def show
    @hotel = Hotel.find(params[:format])
    @comments = @hotel.comments
    @comment = Comment.new
  end

  def create
    @hotel = current_user.hotels.build(hotels_params)
    if @hotel.save
      flash[:success] = "Hotel created"
      redirect_to myhotels_hotel_path 
    else
      flash[:alert] = "Fill required fields"
      redirect_to new_hotel_path
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
      if @hotel.update_attributes(hotels_params)
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
                                     :price, :adress, :star_rating, :photo)
      end
end
