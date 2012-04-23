class Notification < ActiveRecord::Base
	attr_accessible :notification_type_id, :read, :user_id, :user, :notification_type, :notification_object, :notification_object_id, :notification_object_type
	belongs_to :notification_type
	belongs_to :notification_object, :polymorphic => true
	belongs_to :user

	validates :notification_type_id, :presence => true
	validates :notification_object_id, :presence => true
	validates :notification_object_type, :presence => true
	validates :read, :inclusion => {:in => [0, 1]}

	def to_s
		case self.notification_type.name
		when "NewTask"
			"You have been assigned to the following task: " + self.notification_object
		when "NewInvitation"
			"You have been invited to join " + self.notification_object_type
		else
			"Notification: " + self.notification_object
		end
	end
end
