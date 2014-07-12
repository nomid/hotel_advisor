class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :hotel_id
    	t.integer :user_id
    	t.string :comment
    	t.integer :rate

      	t.timestamps
    end
  end
end
