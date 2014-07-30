class Admin::UsersController < AdminController
  def index
    unless params[:sort_by].nil?
      #@users = User.all.order(params[:sort_by])
      @users = User.send(params[:sort_by])
    else
      @users = User.all  
    end
  end
end
