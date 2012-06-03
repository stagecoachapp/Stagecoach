class NotificationsController < ApplicationController

#GET  /notifications
	def index
		#it is necessary to split up read and unread tasks now because unread notifications are marked as read now
		#so read status cannot be checked in the view
		@read_notifications = get_read
		@unread_notifications = get_unread
		@unread_notifications.each do |unread_notification|
			unread_notification.mark_read()
		end
		@title = "Notifications"
		@header = "Notifications"
		respond_to do |format|
			format.html
			format.mobile
		end
	end

	private
	
	def get_unread
		unread_notifications = []
		Notification.all(:conditions => {:user_id => self.current_user.id}, :order => "created_at DESC").each do |notification|
			if not notification.read?
				unread_notifications << notification
			end
		end
		return unread_notifications
	end

	def get_read
		read_notifications = []
		Notification.all(:conditions => {:user_id => self.current_user.id}, :order => "created_at DESC").each do |notification|
			if notification.read?
				read_notifications << notification
			end
		end
		return read_notifications
	end

	def get_unread_count
		return self.get_unread().count
	end

	def get_read_count
		return self.get_read().count
	end

end
