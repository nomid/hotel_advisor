class Admin < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :login, presence: true, length: {maximum: 50}
  
  def Admin.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def Admin.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  private

    def create_remember_token
      self.remember_token = Admin.encrypt(Admin.new_remember_token)
    end
end