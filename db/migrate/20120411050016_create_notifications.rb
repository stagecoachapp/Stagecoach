class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notification_type_id
      t.integer :user_id
      t.integer :read, :default => false
      t.references :notification_object, :polymorphic => true

      t.timestamps
    end
  end
end
