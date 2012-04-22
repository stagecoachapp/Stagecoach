class UpdateTasks < ActiveRecord::Migration
    def change
    	change_table :tasks do |t|
			t.remove :enddate
			t.rename :startdate, :time
			t.integer :owner_id
			t.rename :notes, :description
			t.integer :task_status_id
			t.integer :task_priority_id
			t.boolean :active
		end
    end
end
