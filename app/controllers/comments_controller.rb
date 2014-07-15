class CommentsController < ApplicationController
  include ApplicationHelper
  def create
    @comment = current_user.comments.build(comment_params)
    @hotel = Hotel.find(params[:comment][:hotel_id])
    unless (hotel_commented?(@hotel))
      @comment.hotel_id = params[:comment][:hotel_id]
      if @comment.save
        flash[:success] = 'Comment added'
      else
        if params[:comment][:comment].blank?
          flash[:alert] = 'Comment can\'t be blank' 
        elsif params[:comment][:rate].empty?
          flash[:alert] = 'Rate hotel'
        end 
      end
      redirect_to @hotel
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :rate)
    end
end
