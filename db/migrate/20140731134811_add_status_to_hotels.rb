class AddStatusToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :status, :string, default: 'p'
  end
end
