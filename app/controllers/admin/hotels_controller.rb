class Admin::HotelsController < AdminController
  before_action :check_admin

  def index 
    if (params.has_key?(:filter_by_status) && params[:filter_by_status] != 'all')
      @hotels = Hotel.where(status: params[:filter_by_status])
    else
      @hotels = Hotel.all
    end
  end

  def update
    if params.has_key?(:new_status)
      hotel = Hotel.find(params[:id])
      flash_message = params[:new_status] == 'a' ? 'hotel approved' : 'hotel rejected'
      hotel.update_attribute('status', params[:new_status])
      flash[:success] = flash_message
      redirect_to admin_hotels_path
    end
  end
end
