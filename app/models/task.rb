class Task < ActiveRecord::Base

	has_and_belongs_to_many :users
	has_and_belongs_to_many :task_categories
	has_many :reminders
	belongs_to :project

	validates :name, :presence => true
	validates :startdate, :presence => true
	validates :enddate, :presence => true
	validates_numericality_of :priority
	validates :status, :presence => true

	validates :project_id, :presence => true

	attr_accessible :name, :startdate, :enddate, :notes, :priority, :created_at, :updated_at, :project_id, :status, :task_category_ids, :user_ids

end
