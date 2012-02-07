class DummyUser < ActiveRecord::Base
  has_one :authorizations
  
  def self.create_from_hash!(hash)
    create(:name => hash['extra']['raw_info']['first_name']+" "+hash['extra']['raw_info']['last_name'])
  end
  
end
