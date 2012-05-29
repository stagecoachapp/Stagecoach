module NotificationsHelper
	def notification_path(notification)
		if (notification.notification_type.to_s == "NewTask" or notification.notification_type.to_s == "UpdatedTask" or notification.notification_type.to_s == "CompletedTask") and
		  	notification.notification_object.project != self.current_project
			return notification.notification_object.project
		elsif notification.notification_type.to_s == "NewInvitationMessage"
			return notification.notification_object.conversation.conversation_object
		else
			return notification.notification_object
		end
	end

	#use a post request to switch to the desired project if they click a notification
	#for a task in another project
	def notification_path_method(notification)
		if notification.notification_type.to_s == "NewTask"
			if notification.notification_object.project != self.current_project
				return :post
			end
		end
		return :get
	end
end
