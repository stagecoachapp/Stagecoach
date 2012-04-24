class NotificationMailer < ActionMailer::Base
  default from: "webmaster@projectstagecoach.com"

  def new_task(notification)
  	@notification = notification
  	@task = notification.notification_object
  	mail(:to => notification.user.email, :subject => "You have been assigned a new task on Stagecoach for #{@task.project.to_s}")
  end
end
