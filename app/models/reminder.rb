class Reminder < ActiveRecord::Base
	belongs_to :task
	validates :name, :presence => true
	validates_numericality_of :task_id
	validates :time, :presence => true
	validates :needs_response, :presence => true

	attr_accessible :name, :time, :description, :needs_response, :created_at, :updated_at, :task_id
end
