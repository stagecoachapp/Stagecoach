class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task
      t.integer :assigned_to
      t.integer :assigned_by

      t.timestamps
    end
  end
end
