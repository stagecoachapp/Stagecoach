class CreateEmailSettings < ActiveRecord::Migration
	def change
		create_table :email_settings do |t|
			t.integer :user_id
			t.integer :new_task, :default => 1
			t.integer :new_invitation, :default => 1


			t.timestamps
		end
	end
end
