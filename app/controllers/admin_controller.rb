class AdminController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Admin::SessionsHelper
  layout 'admin'
  
  protected

    def check_admin
      unless admin_signed_in?
        flash[:alert] = 'not accessed'
        redirect_to admin_root_path
      end
    end
end
