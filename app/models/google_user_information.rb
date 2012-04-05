class GoogleUserInformation < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :user

	def self.find_or_create_by_google_id(auth, refresh_token, current_user)
		google_user_information = GoogleUserInformation.find_by_google_id(auth['id'])
		#user does not exist
		if google_user_information.nil?
			current_user ||= User.create(:name => auth['name'])
			google_user_information = GoogleUserInformation.create(:user => current_user, :google_id => auth['id'], :email => auth['email'], :verified_email => auth['verified_email'],
										  :name => auth['name'], :given_name => auth['given_name'], :family_name => auth['family_name'],
										  :profile_picture => auth['picture'], :gender => auth['gender'])
			if current_user.authorization.nil?
				Authorization.create(:user => current_user, :google_refresh_token => refresh_token)

			else
				if current_user.authorization.google_refresh_token != refresh_token && refresh_token != nil
					current_user.authorization.update_attribute(:google_refresh_token => refresh_token)
				end
			end
		end
		google_user_information
    end

end
