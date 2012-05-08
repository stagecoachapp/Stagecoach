class GoogleUserInformation < ActiveRecord::Base
	attr_accessible :user_id, :user, :google_id, :email, :verified_email, :name, :given_name, :family_name, :profile_picture, :gender

	belongs_to :user
	validates_presence_of :user


	def self.find_by_hash(hash)
		google_user_information = GoogleUserInformation.find_by_google_id(hash['id'])
	end

	def self.create_from_hash(hash, refresh_token, user=nil)
		user ||= User.create(:name => hash['name'])
		google_id =  hash['id'] rescue 0
		email = hash['email'] rescue ""
		verified_email = hash['verified_email'] rescue true
		name = hash['name'] rescue ""
		given_name =  hash['given_name'] rescue ""
		family_name = hash['family_name'] rescue ""
		profile_picture = hash['picture'] rescue ""
		gender = hash['gender'] rescue ""
		google_user_information = GoogleUserInformation.create(:user => user, :google_id => google_id, :email => email, :verified_email => verified_email,
															   :name => name, :given_name => given_name, :family_name =>  family_name,
															   :profile_picture => profile_picture, :gender => gender)
	end


	def self.find_or_create_by_hash(hash, refresh_token, user)
		google_user_information = GoogleUserInformation.find_by_hash(hash)
		if google_user_information.nil?
			google_user_information = GoogleUserInformaion.create_from_hash(hash, refresh_token, user)
		end
		google_user_information
    end

end
