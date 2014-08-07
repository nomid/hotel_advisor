class User < ActiveRecord::Base
  has_many :hotels, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[^\.]\.{1}[^\.][a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                  uniqueness:{ case_sensitive: false }
  scope :hotels_desc, ->{
    select('users.*, count(hotels.id) AS hotels_count').
    joins(:hotels).
    group('hotels.user_id').
    order('hotels_count DESC') }
  scope :hotels_asc, ->{
    select('users.*, count(hotels.id) AS hotels_count').
    joins(:hotels).
    group('hotels.user_id').
    order('hotels_count') }
  scope :username_desc, ->{
    all.order('username DESC') }
  scope :username_asc, ->{
    all.order('username') }
  scope :email_desc, ->{
    all.order('email DESC') }
  scope :email_asc, ->{
    all.order('email') }
  scope :comments_desc, ->{
    select('users.*, count(comments.id) AS comments_count').
    joins(:comments).
    group('comments.user_id').
    order('comments_count DESC') }
  scope :comments_asc, ->{
    select('users.*, count(comments.id) AS comments_count').
    joins(:comments).
    group('comments.user_id').
    order('comments_count') }

end
