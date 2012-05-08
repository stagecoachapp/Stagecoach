class FacebookUserInformation < ActiveRecord::Base
  attr_accessible :user, :user_id, :uid, :email, :name, :profile_picture, :location, :location_id, :token, :expires_at, :expires, :gender
  belongs_to :user


	def self.find_by_hash(hash)
		FacebookUserInformation.find_by_uid(hash['uid'])
	end

	def self.create_from_hash(hash, user=nil)
		user ||= User.create(:name => hash['info']['name'])
		#necessary in case we don't get the right data or Facebook changes their format
		uid = hash['uid'] rescue 0
		email = hash['info']['email'] rescue ""
		name = hash['info']['name'] rescue ""
		profile_picture = hash['info']['image'] rescue ""
		location = hash['extra']['raw_info']['location']['name'] rescue ""
		location_id = hash['extra']['raw_info']['location']['id'] rescue "0"
		token = hash['credentials']['token'] rescue 0
		#expires_at = hash['credentials']['expires_at'] rescue DateTime.now
		expires = hash['credentials']['expires'] rescue 1
		expires = expires == true ? 1 : 0
		gender = hash['extra']['gender'] rescue ""
		facebook_user_information = FacebookUserInformation.create(:user => user, :uid => uid, :email => email, :name => name,
																   :profile_picture => profile_picture, :location => location, :token => token, :location_id => location_id,
																   :expires => expires, :gender => gender)
	end
end
