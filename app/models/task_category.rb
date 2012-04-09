class TaskCategory < ActiveRecord::Base
	has_and_belongs_to_many :tasks
	belongs_to :project
	validates :name, :presence => true
	#validates_numericality_of :project_id

	attr_accessible :name, :created_at, :updated_at, :project_id, :task_category_ids
end
