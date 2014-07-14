class StaticPagesController < ApplicationController
	include StaticPagesHelper
  	def home
	  	@hotels = Hotel.paginate(page: params[:page]).order('title')
  	end

  	def top
	  	ids = get_top_5_ids
	  	@hotels = Hotel.find(ids).index_by(&:id).slice(*ids).values
	end
end
