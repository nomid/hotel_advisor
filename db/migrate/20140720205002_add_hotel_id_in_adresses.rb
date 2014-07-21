class AddHotelIdInAdresses < ActiveRecord::Migration
  def change
  	add_column :adresses, :hotel_id, :integer
  end
end
