class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def change
  	change_table :hotels do |t|
		t.change :user, :user_id
  	end
  end
end
