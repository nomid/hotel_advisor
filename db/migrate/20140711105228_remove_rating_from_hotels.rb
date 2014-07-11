class RemoveRatingFromHotels < ActiveRecord::Migration
  def change
    remove_column :hotels, :rating, :integer
  end
end
