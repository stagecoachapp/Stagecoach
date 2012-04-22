class Task < ActiveRecord::Base
	attr_accessible :name, :time, :description, :created_at, :updated_at, :project_id, :project, :task_status, :task_status_id, :task_priority_id, :task_priority, :task_category_ids, :user_ids

	has_and_belongs_to_many :users
	has_and_belongs_to_many :task_categories
	has_many :notifications, :as => :notification_object, :dependent => :destroy
	belongs_to :project
	belongs_to :task_status
	belongs_to :task_priority
	belongs_to :owner, :class_name => "User", :foreign_key => :owner_id

	validates :name, :presence => true
	validates :task_priority_id, :presence => true
	validates :task_status, :presence => true

	validates :project_id, :presence => true

	def to_s
		self.name
	end

	def formatted_time
		if self.time.nil?
			return "No Start Date"
		else
			return self.time.strftime("%a %b %d %I:%M%p")
		end
	end

end
