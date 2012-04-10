class GoogleUserInformation < ActiveRecord::Base

	belongs_to :user
	validates_presence_of :user
	attr_accessible :user_id, :user, :google_id, :email, :verified_email, :name, :given_name, :family_name, :profile_picture, :gender

end
