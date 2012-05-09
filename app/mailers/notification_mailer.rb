class NotificationMailer < AsyncMailer
    default from: "notifications@projectstagecoach.com"

    def default(notification_id)
        @notification = Notification.find_by_id(notification_id)
        message = mail(:to => @notification.user.email, :subject => "You have a new notification on Stagecoach")
        message.delivery_method.settings.merge!({:user_name => "notifications@projectstagecoach.com"})
    end

    def new_task(notification_id)
        @notification = Notification.find_by_id(notification_id)
        @task = @notification.notification_object
        message = mail(:to => @notification.user.email, :subject => "You have been assigned a new task on Stagecoach for #{@task.project.to_s}")
        #required because the from field actually requires different smtp settings to
        message.delivery_method.settings.merge!({:user_name => "notifications@projectstagecoach.com"})
    end

    def new_invitation(notification_id)
        @notification = Notification.find_by_id(notification_id)
        @invitation = @notification.notification_object
        message = mail(:to => @notification.user.email, :subject => "You have been invited to join #{@invitation.project.to_s}")
        #required because the from field actually requires different smtp settings to
        message.delivery_method.settings.merge!({:user_name => "notifications@projectstagecoach.com"})
    end

    def new_invitation_message(notification_id)
        @notification = Notification.find_by_id(notification_id)
        @invitation_message = @notification.notification_object
        @invitation = @invitation_message.conversation.conversation_object
        message = mail(:to => @notification.user.email, :subject => "You have a new message in your invitation to join #{@invitation.project.to_s}")
        #required because the from field actually requires different smtp settings to
        message.delivery_method.settings.merge!({:user_name => "notifications@projectstagecoach.com"})
    end

    def new_project_asset(notification_id)
        @notification = Notification.find_by_id(notification_id)
        @asset = @notification.notification_object
        message = mail(:to => @notification.user.email, :subject => "A new asset has been uploaded for #{@asset.asset_object.to_s}")
        #required because the from field actually requires different smtp settings to
        message.delivery_method.settings.merge!({:user_name => "notifications@projectstagecoach.com"})
    end

end


