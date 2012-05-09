# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


# Default user roles
default_user_roles = [
	"Directing Team",
	"Producing Team",
	"Camera",
	"Lighting",
	"Art Department",
	"Documentation Team",
	"Sound/Audio",
	"Talent",
	"Vendors",
	"Music Dept",
	"Visual/Special Effects",
	"Stunts",
	"Editorial",
	"Transportation",
	"Other",
]

UserRole.delete_all
for role in default_user_roles
	UserRole.create(:name => role)
end

# Default notification types
default_notification_types = [
	"Default",
	"NewTask",
	"NewInvitation",
	"NewInvitationMessage",
	"NewProjectAsset"
]

NotificationType.delete_all
for type in default_notification_types
	NotificationType.create(:name => type)
end

# Default task status
default_task_statuses = [
	"Pending",
	"Complete",
]

TaskStatus.delete_all
for status in default_task_statuses
	TaskStatus.create(:name => status)
end

# Default task priorities
default_task_priorities = [
	"Low",
	"High",
]

TaskPriority.delete_all
for priority in default_task_priorities
	TaskPriority.create(:name => priority)
end
