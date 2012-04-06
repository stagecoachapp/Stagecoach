class TaskUser < ActiveRecord::Base

	attr_accessible :task_id, :user_id
end