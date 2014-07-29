class RenamePasswordColumn < ActiveRecord::Migration
  def change
  	rename_column :admins, :password, :password_digest
  end
end
