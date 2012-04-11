class Notification < ActiveRecord::Base
	attr_accessible :notification_type_id, :read, :user_id, :user, :notification_type, :notification_object, :notification_object_id, :notification_object_type
	belongs_to :notification_type
	belongs_to :notification_object, :polymorphic => true
	belongs_to :user

	after_initialize :default_values

	validates :notification_type_id, :presence => true
	validates :notification_object_id, :presence => true
	validates :notification_object_type, :presence => true
	validates :read, :inclusion => {:in => [true, false]}

	def to_s
		case self.notification_type.name
		when "New Task"
			"You have been assigned to the following task: " + self.notification_object.to_s
		else
			"Notification: " + self.notification_type.name
		end
	end

	private
		def default_values
			self.read = false
		end
end
