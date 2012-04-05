class CreateGoogleUserInformations < ActiveRecord::Migration
  def change
    create_table :google_user_informations do |t|
      t.integer :user_id
      t.string :google_id
      t.string :email
      t.boolean :verified_email
      t.string :name
      t.string :given_name
      t.string :family_name
      t.string :profile_picture
      t.string :gender

      t.timestamps
    end
  end
end
