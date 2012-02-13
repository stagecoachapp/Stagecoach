class UserRole < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :project
	validates :name, :presence => true
	validates_numericality_of :project_id
end
