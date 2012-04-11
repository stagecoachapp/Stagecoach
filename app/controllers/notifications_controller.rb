class NotificationsController < ApplicationController

#GET  /notifications
	def index

		@notifications = self.current_user.notifications

		@header = "Notifications"
		respond_to do |format|
			format.html
			format.mobile
		end

	end

end
