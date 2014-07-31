class StaticPagesController < ApplicationController
  include StaticPagesHelper
  def home
    @hotels = Hotel.paginate(page: params[:page]).where(status: 'a').order('title')
  end

  def top
    @hotels = Hotel::top_5
  end
end
