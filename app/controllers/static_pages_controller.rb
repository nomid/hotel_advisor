class StaticPagesController < ApplicationController
  include StaticPagesHelper
  def home
    @hotels = Hotel.paginate(page: params[:page]).order('title')
  end

  def top
    @hotels = Hotel::top_5
  end
end
