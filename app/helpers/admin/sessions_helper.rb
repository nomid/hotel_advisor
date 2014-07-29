
module Admin::SessionsHelper

	def admin_sign_in(admin)
	    remember_token = Admin.new_remember_token
	    cookies.permanent[:remember_token] = remember_token
	    admin.update_attribute(:remember_token, Admin.encrypt(remember_token))
	    self.current_admin = admin
  	end

  	def admin_signed_in?
    	!current_admin.nil?
  	end
  	
  	def current_admin=(admin)
	    @current_admin = admin
  	end

  	def current_admin
	    remember_token = Admin.encrypt(cookies[:remember_token])
	    @current_admin ||= Admin.find_by(remember_token: remember_token)
  	end

    def current_admin?(admin)
      admin == current_admin
    end

    def signed_in_admin
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
  
    def sign_out
      current_admin.update_attribute(:remember_token,
                                    Admin.encrypt(Admin.new_remember_token))
      cookies.delete(:remember_token)
      self.current_admin = nil
    end

    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end

    def store_location
      session[:return_to] = request.url if request.get?
    end

end

