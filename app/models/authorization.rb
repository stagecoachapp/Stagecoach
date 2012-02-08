class Authorization < ActiveRecord::Base
  belongs_to :dummy_user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end
  
  def self.create_from_hash(hash, dummy_user = nil)
    dummy_user ||= DummyUser.create_from_hash!(hash)
    Authorization.create(:dummy_user => dummy_user, :uid => hash['uid'], :provider => hash['provider'])
  end
  
end
