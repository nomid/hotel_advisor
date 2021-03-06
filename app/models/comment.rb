class Comment < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :user
  validates :comment, presence: true, length: {maximum: 200}
  validates :rate, presence: true, inclusion: {in: 1..5}
  validates :user_id, presence: true
  validates :hotel_id, presence: true
end
