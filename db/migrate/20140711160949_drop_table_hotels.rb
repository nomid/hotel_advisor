class DropTableHotels < ActiveRecord::Migration
  def change
  	drop_table :hotels
  end
end
