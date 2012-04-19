class Project < ActiveRecord::Base
	attr_accessible :name, :created_at, :updated_at, :password
	has_and_belongs_to_many :users
	has_many :tasks
	has_many :task_categories
	has_many :user_roles

	validates :name, :presence => true

	def capitalized_name
		name.split(' ').map {|w| w.capitalize }.join(' ')
	end

end
