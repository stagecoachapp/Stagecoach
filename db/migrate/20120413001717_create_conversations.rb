class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|

      t.timestamps
    end
  end
end
