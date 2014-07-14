class StaticPagesController < ApplicationController
	include StaticPagesHelper
  def home
  	@hotels = Hotel.paginate(page: params[:page]).order('title')
  end

  def top
  	#@hotels = Hotel.order('rating DESC').limit(5)
  	@hotels = Hotel.find(get_top_5_ids)
  end
end
