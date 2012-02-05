class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :startdate
      t.datetime :enddate
      t.text :notes
      t.integer :priority
      t.string :status

      t.timestamps
    end
  end
end
