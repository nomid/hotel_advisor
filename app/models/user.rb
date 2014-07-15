class User < ActiveRecord::Base
  has_many :hotels, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[^\.]\.{1}[^\.][a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                  uniqueness:{ case_sensitive: false }
end
