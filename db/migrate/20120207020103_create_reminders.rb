class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.datetime :time
      t.text :description
      t.boolean :needs_response

      t.timestamps
    end
  end
end
