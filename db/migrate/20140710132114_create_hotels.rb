class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :title
      t.integer :rating
      t.boolean :breackfest
      t.string :room_desc
      t.string :photo
      t.float :price
      t.string :adress

      t.timestamps
    end
  end
end
