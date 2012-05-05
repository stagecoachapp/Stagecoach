class Notification < ActiveRecord::Base
	attr_accessible :notification_type_id, :read, :user_id, :user, :notification_type, :notification_object, :notification_object_id, :notification_object_type
	belongs_to :notification_type
	belongs_to :notification_object, :polymorphic => true
	belongs_to :user

	validates :notification_type_id, :presence => true
	validates :notification_object_id, :presence => true
	validates :notification_object_type, :presence => true
	validates :read, :inclusion => {:in => [0, 1]}

	after_create :send_notification_email

	def to_s
		case self.notification_type.to_s
		when "NewTask"
			"You have been assigned to the following task: " + self.notification_object.to_s + " on " + self.notification_object.project.to_s + " by " + self.notification_object.owner.name
		when "NewInvitation"
			"You have been invited to join " + self.notification_object.project.to_s + " by " + self.notification_object.from_user.to_s
		when "NewInvitationMessage"
			"You have a new message in your invitation to join " + self.notification_object.conversation.conversation_object.project.to_s + " from " + self.notification_object.user.to_s
		else
			"Notification: " + self.notification_object.to_s + " on " + self.notification_object.project.to_s
		end
	end

	def mark_read
		self.update_attribute("read", 1)
	end

	def mark_unread
		self.update_attribute("read", 0)
	end

	private
		def send_notification_email

			if self.notification_type.to_s == "NewTask"
				if self.user.email_setting.new_task == 1
					NotificationMailer.new_task(self.id).deliver
				end
			elsif self.notification_type.to_s == "NewInvitation"
				if self.user.email_setting.new_invitation == 1
					NotificationMailer.new_invitation(self.id).deliver
				end
			elsif self.notification_type.to_s == "NewInvitationMessage"
				if self.user.email_setting.new_invitation_message == 1
					NotificationMailer.new_invitation_message(self.id).deliver
				end
			end
		end
end
