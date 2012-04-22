# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


# Default user roles
UserRole.delete_all
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
for role in default_user_roles
	UserRole.create(:name => role)
end
