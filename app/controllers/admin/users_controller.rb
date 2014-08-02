class Admin::UsersController < AdminController
  before_action :check_admin

  def index
    unless params[:sort_by].nil?
      @users = User.send(params[:sort_by]).paginate(page:params[:page])
    else
      @users = User.paginate(page:params[:page]).all
    end
    if params.has_key?(:filter_by_name) || params.has_key?(:filter_by_email)
      filter_by_name =  params.has_key?(:filter_by_name) ? params[:filter_by_name].downcase : ''
      filter_by_email =  params.has_key?(:filter_by_email) ? params[:filter_by_email].downcase : ''
      
      new_users = []
      @users.each do |user|
        new_users << user if (user.username.downcase.include?(filter_by_name) && user.email.downcase.include?(filter_by_email))
      end
      if new_users.any?
        @users = new_users
      else
        @users = nil
      end
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = 'user deleted'
    redirect_to admin_users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created'
      redirect_to admin_users_path
    else
      flash.now[:alert] = 'Validation error'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'User updated'
      redirect_to admin_users_path
    else
      flash.now[:alert] = 'Validation error'
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  
end
