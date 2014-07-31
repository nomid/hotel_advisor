class Admin < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :login, presence: true, length: {maximum: 50}
  
  def Admin.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Admin.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Admin.encrypt(Admin.new_remember_token)
    end
end