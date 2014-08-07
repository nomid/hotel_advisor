module ControllerMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def it_should_check_admin_for_actions(*actions)
      actions.each do |action|
        it "#{action} action should check admin" do
          get action, :id => 1
          expect(response).to redirect_to(admin_root_path)
          expect(flash[:alert]).not_to be_nil
        end
      end
    end
  end
  
  def admin_login(admin)
    remember_token = Admin.new_remember_token
    cookies[:remember_token] = remember_token
    admin.update_attribute(:remember_token, Admin.encrypt(remember_token))
  end
end

