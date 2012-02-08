class Project < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :tasks
	has_many :task_categories
	has_many :user_roles
end
