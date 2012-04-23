class RenameProjectPasswordToPasswordHash < ActiveRecord::Migration
  def change
  	change_table :projects do |t|
  		t.rename :password, :password_hash
  	end
  end
end
