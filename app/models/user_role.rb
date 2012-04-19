class UserRole < ActiveRecord::Base
	attr_accessible :name, :project_id
	has_and_belongs_to_many :users
	belongs_to :project
	validates :name, :presence => true
end
