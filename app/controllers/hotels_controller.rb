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
		#@hotel = Hotel.new(hotels_params)
		@hotel = current_user.hotels.build(hotels_params)
		@hotel.save!
		redirect_to root_url	
		
	end

	def myhotels
		@hotels = current_user.hotels.paginate(page:params[:page])
	end

	def edit
		@hotel = Hotel.find(params[:format])
	end

	def update
		#todo: protect from notaccessed edit
		@hotel = current_user.hotels.find(params[:hotel][:id])
		if !@hotel
			redirect_to root_path
		end
		if @hotel.update_attributes(hotels_params)
      		flash[:success] = "Hotel updated"
      		redirect_to myhotels_hotel_path
	    else
      		render 'edit'
	    end
	end

	def destroy
		hotel = current_user.hotels.find(params[:format])
		if hotel
			hotel.destroy
		    flash[:success] = "Hotel deleted."
		    redirect_to myhotels_hotel_path
	    end
  	end

	private
		def hotels_params
	      	params.require(:hotel).permit(:title, :breackfest, :room_desc,
	                                   :price, :adress, :star_rating, :photo)
	    end
end
