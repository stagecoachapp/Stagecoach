class CreateNotificationTypes < ActiveRecord::Migration
  def change
    create_table :notification_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
