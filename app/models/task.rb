class Task < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :task_category
	has_many :reminders
	belongs_to :project
	validates :name, :presence => true
	#validates :startdate, :presence => true
	#validates :enddate, :presence => true
	#validates_numericality_of :priority
	#validates :status, :presence => true
	#validates_numericality_of :project_id
end
