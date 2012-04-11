class NotificationsController < ApplicationController

#GET  /notifications
	def index

		notifications = self.current_user.notifications

		#it is necessary to split up read and unread tasks now because unread notifications are marked as read now
		#so read status cannot be checked in the view
		@read_notifications = []
		@unread_notifications = []
		notifications.find(:all, :order => 'created_at DESC').each do |notification|
			if notification.read?
				@read_notifications << notification

			else
				@unread_notifications << notification
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
