module Admin::UsersHelper
  def sort_link(sort)
    if params[:sort_by] == "#{sort}_asc"
      link_to sort, admin_users_path(sort_by: "#{sort}_desc")
    else
      link_to sort, admin_users_path(sort_by: "#{sort}_asc")
    end
  end
end
