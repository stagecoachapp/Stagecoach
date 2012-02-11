class Task < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :task_category
	has_many :reminders
	belongs_to :project
end
