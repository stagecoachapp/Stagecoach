class Administrator < ActiveRecord::Base
	attr_accessible :user_id, :user, :project_id, :project
end
