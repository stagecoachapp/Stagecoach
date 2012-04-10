class Authorization < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :user_id
    validates_uniqueness_of :uid, :scope => :provider
    validates_uniqueness_of :google_refresh_token
    attr_accessible :provider, :user_id, :user, :uid, :google_refresh_token

    def self.find_by_facebook_hash(hash)
        find_by_provider_and_uid(hash['provider'], hash['uid'])
    end

    def self.create_from_facebook_hash(hash, user = nil)
        user ||= User.create_from_facebook_hash!(hash)
        if user.authorization.nil?
            authorization = Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
        else
            authorization = user.authorization.update_attributes(:uid => hash['uid'], :provider => hash['provider'])
        end
        authorization
    end

    def self.find_or_create_from_facebook_hash(hash, user = nil)
        authoriztion = find_by_facebook_hash(hash)

        if authoriztion.nil?
            authorization = create_from_facebook_hash(hash, user)
        end
        authoriztion
    end

    def self.find_by_google_hash(hash)
        google_user_information = GoogleUserInformation.find_by_google_id(hash['id'])

        if google_user_information.nil?
            false
            return
        end
        if google_user_information.user.nil?
            false
            return
        end
        google_user_information.user.authorization
    end

    def self.create_from_google_hash(hash, refresh_token, user)
        user ||= User.create_from_google_hash(hash)
        google_user_information = GoogleUserInformation.create(:user => user, :google_id => hash['id'], :email => hash['email'], :verified_email => hash['verified_email'],
                                      :name => hash['name'], :given_name => hash['given_name'], :family_name => hash['family_name'],
                                      :profile_picture => hash['picture'], :gender => hash['gender'])
        if user.authorization.nil?
            authorization = Authorization.create(:user => user, :google_refresh_token => refresh_token)
        #the user already has an authentication. Only update the refresh token if it is different and not null
        else
            authorization = user.authorization
            if authorization.google_refresh_token != refresh_token && refresh_token != nil
                authorization.update_attribute(:google_refresh_token, refresh_token)
            end
        end
        authorization
    end


    def self.find_or_create_by_google_hash(hash, refresh_token, user)
        authorization = find_by_google_hash(hash)
        if authorization.nil?
            authorization = create_from_google_hash(hash, refresh_token, user)
        end
        authorization
    end



end
