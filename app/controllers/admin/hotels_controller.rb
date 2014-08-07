class Admin::HotelsController < AdminController
  before_action :check_admin

  def index 
    if (params.has_key?(:filter_by_status) && params[:filter_by_status] != 'all')
      @hotels = Hotel.where(status: params[:filter_by_status]).paginate(page:params[:page])
    else
      @hotels = Hotel.all.paginate(page:params[:page])
    end
  end

  def update
    if params.has_key?(:new_status)
      hotel = Hotel.find(params[:id])
      if params[:new_status] == 'a'
        flash_message = 'hotel approved'
        HotelMailer.approve_hotel(hotel).deliver
      elsif params[:new_status] == 'r'
        flash_message = 'hotel rejected'
        HotelMailer.reject_hotel(hotel).deliver
      end
      hotel.update_attribute('status', params[:new_status])
      flash[:success] = flash_message
      redirect_to admin_hotels_path
    end
  end
end
