class TaskCategory < ActiveRecord::Base
	has_and_belongs_to_many :tasks
	belongs_to :project
end
