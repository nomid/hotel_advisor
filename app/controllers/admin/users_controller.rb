class Admin::UsersController < AdminController
  before_action :check_admin

  def index
    unless params[:sort_by].nil?
      #todo: add paginate
      @users = User.send(params[:sort_by])
    else
      @users = User.all
      #@users = User.paginate(page:params[:page]).all
    end
    unless params[:filter_by_name].nil?
      new_users = []
      @users.each do |user|
        new_users << user if user.username.include? params[:filter_by_name]
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
