class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phonenumber
      t.string :smartphone
      t.boolean :activated

      t.timestamps
    end
  end
end
