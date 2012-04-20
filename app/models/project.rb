class Project < ActiveRecord::Base
	attr_accessible :name, :created_at, :updated_at, :password, :owner_id, :owner
	has_and_belongs_to_many :users
	has_and_belongs_to_many :administrators, :class_name => "User", :join_table => "administrators"
	belongs_to :owner, :class_name => "User"
	has_many :tasks
	has_many :task_categories
	has_many :user_roles

	validates :name, :presence => true

	def capitalized_name
		name.split(' ').map {|w| w.capitalize }.join(' ')
	end

end
