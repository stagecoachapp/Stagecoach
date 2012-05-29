class CreateInvitationToUsers < ActiveRecord::Migration
  def change
    create_table :invitation_to_users do |t|
      t.integer :invitation_id
      t.integer :to_user_id

      t.timestamps
    end
    remove_column :invitations, :to_user
  end
end
