class CommentsController < ApplicationController
	include ApplicationHelper
	def create
		@comment = current_user.comments.build(micropost_params)
		hotel = Hotel.find(params[:comment][:hotel_id])
		unless (hotel_commented?(hotel))
			@comment.hotel_id = params[:comment][:hotel_id]
			@comment.save!
			redirect_to hotel
		end

	end

	private
		def micropost_params
	      params.require(:comment).permit(:comment, :rate)
	    end
end
