class StaticPagesController < ApplicationController
  def home
  	@hotels = Hotel.paginate(page: params[:page])
  end

  def top
  	@hotels = Hotel.order('rating DESC').limit(5)
  end
end
