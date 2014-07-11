class AddRatingToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :rating, :float
    add_column :hotels, :star_rating, :integer
  end
end
