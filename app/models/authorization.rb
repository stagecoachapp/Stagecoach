class Authorization < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :user_id
    validates_uniqueness_of :uid, :scope => :provider

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

end
