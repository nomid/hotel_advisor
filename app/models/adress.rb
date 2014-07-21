class Adress < ActiveRecord::Base
	belongs_to :hotel
	validates :country, presence: true, length: {maximum: 60}
	validates :state, length: {maximum: 60}
	validates :city, presence: true, length: {maximum: 60}
	validates :street, presence: true, length: {maximum: 60}
end
