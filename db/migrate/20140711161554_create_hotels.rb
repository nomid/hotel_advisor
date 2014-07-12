class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :title
      t.integer :star_rating
      t.boolean :breackfest
      t.string :room_desc
      t.string :photo
      t.float :price
      t.string :adress
      t.integer :user_id

      t.timestamps
    end
  end
end
