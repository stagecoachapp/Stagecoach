class NotificationMailer < AsyncMailer
  default from: "webmaster@projectstagecoach.com"

  def new_task(notification_id)
  	@notification = Notification.find_by_id(notification_id)
  	@task = @notification.notification_object
  	mail(:to => @notification.user.email, :subject => "You have been assigned a new task on Stagecoach for #{@task.project.to_s}")
  end

  def default(notification_id)
  	@notification = Notification.find_by_id(notification_id)
  	mail(:to => @notification.user.email, :subject => "You have a new notification on Stagecoach")
  end
end
