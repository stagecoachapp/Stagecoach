class Changelog < ActiveRecord::Base
	attr_accessible :description, :developer, :created_at, :updated_at

end
