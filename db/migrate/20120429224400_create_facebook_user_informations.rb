class CreateFacebookUserInformations < ActiveRecord::Migration
	def change
		create_table :facebook_user_informations do |t|
			t.integer :user_id
			t.integer :uid
			t.string :email
			t.string :name
			t.string :profile_picture
			t.string :location
			t.string :location_id
			t.string :token
			t.datetime :expires_at
			t.integer :expires
			t.string :gender

			t.timestamps
		end

		drop_table :authorizations
		add_column :google_user_informations, :refresh_token, :string

	end
end
