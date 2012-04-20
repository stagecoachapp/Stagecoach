# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

NotificationType.create(:name => "Default")
NotificationType.create(:name => "NewTask")
TaskStatus.create(:name => "Pending")
TaskStatus.create(:name => "Late")
TaskStatus.create(:name => "Complete")
TaskStatus.create(:name => "LateComplete")
TaskPriority.create(:name => "Low")
TaskPriority.create(:name => "High")