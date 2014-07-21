class RemoveAdressFromHotels < ActiveRecord::Migration
  def change
  	remove_column :hotels, :adress, :string
  end
end
