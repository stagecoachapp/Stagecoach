class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :user_id
      t.string :type
      t.integer :conversation_id

      t.timestamps
    end
  end
end
