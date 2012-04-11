class NotificationsController < ApplicationController

#GET  /notifications
	def index

		notifications = self.current_user.notifications

		@read_notifications = []
		@unread_notification = []
		notifications.each do |notification|
			if notification.read?
				@read_notifications << notification

			else
				@unread_notification << notification
				notification.update_attribute("read", 1)
			end
		end
		@header = "Notifications"
		respond_to do |format|
			format.html
			format.mobile
		end

	end

end
