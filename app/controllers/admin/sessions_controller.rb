class Admin::SessionsController < AdminController
  def new
    if admin_signed_in?
      redirect_to admin_main_path
    end
    @admin = Admin.new
  end

  def create
    admin = Admin.find_by(login: params[:admin][:login].downcase)
    if admin && admin.authenticate(params[:admin][:password])
      admin_sign_in admin
      redirect_to admin_main_path
      #redirect_back_or admin
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end