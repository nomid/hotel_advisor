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

	private
		def hotels_params
	      	params.require(:hotel).permit(:title, :breackfest, :room_desc,
	                                   :price, :adress, :star_rating, :photo)
	    end
end
