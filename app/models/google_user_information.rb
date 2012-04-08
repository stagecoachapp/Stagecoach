class GoogleUserInformation < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :user

	def self.find_by_google_hash(hash)
		google_user_information = GoogleUserInformation.find_by_google_id(hash['id'])
	end

	def self.create_from_google_hash(hash, refresh_token, user)
		user ||= User.create(:name => hash['name'])
		google_user_information = GoogleUserInformation.create(:user => user, :google_id => hash['id'], :email => hash['email'], :verified_email => hash['verified_email'],
									  :name => hash['name'], :given_name => hash['given_name'], :family_name => hash['family_name'],
									  :profile_picture => hash['picture'], :gender => hash['gender'])
		if user.authorization.nil?
			authorization = Authorization.create(:user => user, :google_refresh_token => refresh_token)
		#the user already has an authentication. Only update the refresh token if it is different and not null
		else
			if user.authorization.google_refresh_token != refresh_token && refresh_token != nil
				user.authorization.update_attribute(:google_refresh_token, refresh_token)
			end
		end
		google_user_information
	end


	def self.find_or_create_by_google_hash(hash, refresh_token, user)
		google_user_information = find_by_google_hash(hash)
		if google_user_information.nil?
			google_user_information = create_from_google_hash(hash, refresh_token, user)
		end
		google_user_information
    end

end
