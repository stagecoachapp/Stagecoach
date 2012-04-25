class NotificationMailer < AsyncMailer
    default from: "notifications@projectstagecoach.com"


    def new_task(notification_id)
        @notification = Notification.find_by_id(notification_id)
        @task = @notification.notification_object
        message = mail(:to => @notification.user.email, :subject => "You have been assigned a new task on Stagecoach for #{@task.project.to_s}")
        #required because the from field actually requires different smtp settings to
        message.delivery_method.settings.merge!({:user_name => "notifications@projectstagecoach.com"})
    end

    def default(notification_id)
        @notification = Notification.find_by_id(notification_id)
        message = mail(:to => @notification.user.email, :subject => "You have a new notification on Stagecoach")
        message.delivery_method.settings.merge!({:user_name => "notifications@projectstagecoach.com"})
    end
end


