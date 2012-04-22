# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

# Development seed data
development_users = ["Test User 1", "Test User 2", "Test User 3"]
development_projects = ["Test Project 1", "Test Project 2"]

for project_name in development_projects do
	Project.create(:name => project_name, :password => "password")
end