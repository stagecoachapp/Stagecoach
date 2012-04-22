class RemovePriorityFromTasks < ActiveRecord::Migration
  def change
  	change_table :tasks do |t|
  		t.remove :priority
  	end
  end
end
