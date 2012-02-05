class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :name
      t.string :email
      t.boolean :activated

      t.timestamps
    end
  end
end
