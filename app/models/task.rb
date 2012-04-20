class Task < ActiveRecord::Base
	attr_accessible :name, :time, :description, :created_at, :updated_at, :project_id, :project, :task_status, :task_status_id, :task_priority_id, :task_priority, :task_category_ids, :user_ids

	has_and_belongs_to_many :users
	has_and_belongs_to_many :task_categories
	has_many :notifications, :as => :notification_object, :dependent => :destroy
	belongs_to :project
	belongs_to :task_status
	belongs_to :task_priority

	validates :name, :presence => true
	validates_numericality_of :priority
	validates :status, :presence => true

	validates :project_id, :presence => true

	def to_s
		self.name
	end

	def formatted_startdate
		if self.startdate.nil?
			return "No Start Date"
		else
			return self.startdate.strftime("%a %b %d %I:%M%p")
		end
	end

	def formatted_enddate
		if self.enddate.nil?
			return "No End Date"
		else
			return self.enddate.strftime("%a %b %d %I:%M%p")
		end
	end

end
