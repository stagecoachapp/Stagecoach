class RemoveStatusFromTasks < ActiveRecord::Migration
  def up
  	remove_column :tasks, :status
  end

  def down
  	add_column :tasks, :status, :integer
  end
end
