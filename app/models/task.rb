class Task < ActiveRecord::Base
	attr_accessible :name, :startdate, :enddate, :notes, :priority, :created_at, :updated_at, :project_id, :status, :task_category_ids, :user_ids

	has_and_belongs_to_many :users
	has_and_belongs_to_many :task_categories
	has_many :reminders
	has_many :notifications, :as => :notification_object, :dependent => :destroy
	belongs_to :project

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
