class NotificationType < ActiveRecord::Base
	attr_accessible :name
	has_many :notifications
end
