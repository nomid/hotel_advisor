class AddUserToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :user, :integer
  end
end
