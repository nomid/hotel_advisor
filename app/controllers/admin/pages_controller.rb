class Admin::PagesController < AdminController
  def main
    unless admin_signed_in?
      flash[:notice] = 'Not accessed'
      redirect_to admin_root_path
    end
  end
end
