class StaticPagesController < ApplicationController
  def home
  	@hotels = Hotel.paginate(page: params[:page]).order('title')
  end

  def top
  	@hotels = Hotel.order('rating DESC').limit(5)
  end
end
