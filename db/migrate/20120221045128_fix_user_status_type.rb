class FixUserStatusType < ActiveRecord::Migration
	def change
		change_table :tasks do |t|
			t.remove :status
			t.integer :status
		end
	end
end
