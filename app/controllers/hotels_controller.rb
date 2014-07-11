class HotelsController < ApplicationController
  def index
  	@hotels = Hotel.paginate(page: params[:page])
  end
end
