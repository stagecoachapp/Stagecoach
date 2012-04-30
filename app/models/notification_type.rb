class NotificationType < ActiveRecord::Base
	attr_accessible :name
	has_many :notifications


	def to_s
		self.name
	end
end
