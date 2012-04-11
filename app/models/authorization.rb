class Authorization < ActiveRecord::Base
    attr_accessible :provider, :uid, :user_id, :created_at, :updated_at
    belongs_to :user
    validates_presence_of :user_id, :uid, :provider
    validates_uniqueness_of :uid, :scope => :provider

    def self.find_from_hash(hash)
        find_by_provider_and_uid(hash['provider'], hash['uid'])
    end

    def self.create_from_hash(auth, user = nil)
        user ||= User.create_from_hash!(auth)
        Authorization.create(:user => user, :uid => auth['uid'], :provider => auth['provider'])
    end


end
