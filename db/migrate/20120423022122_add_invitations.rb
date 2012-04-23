class AddInvitations < ActiveRecord::Migration
  def change
  	create_table :invitations do |t|
  		t.string :header
  		t.datetime :start_date
  		t.datetime :end_date
  		t.text :body
  		t.integer :from_user_id
  		t.integer :to_user_id

  		t.timestamps
  	end
  end
end
