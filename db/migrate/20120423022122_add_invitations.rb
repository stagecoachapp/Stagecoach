class AddInvitations < ActiveRecord::Migration
  def change
  	create_table :invitations do |t|
  		t.string :subject
  		t.text :body
  		t.integer :to_user_id
      t.integer :from_user_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer :project_id

  		t.timestamps
  	end
  end
end
