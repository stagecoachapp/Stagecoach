class NotificationMailerJob
	@queue = :mailer_queue

	def self.perform(notification_id)
		notification = Notification.find_by_id(notification_id)
		if notification.notification_type == "NewTask"
			NotificationMailer.new_task(notification_id).deliver
		else
			NotificationMailer.default(notification_id).deliver
		end
	end

end