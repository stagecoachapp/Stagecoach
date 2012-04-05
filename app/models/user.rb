class User < ActiveRecord::Base
    has_and_belongs_to_many :user_roles
    has_and_belongs_to_many :tasks
    has_and_belongs_to_many :projects
	has_one :authorization
    has_one :google_user_information

    	after_initialize :default_values

    def self.create_from_facebook_hash!(auth)
        create(:name => auth['info']['name'], :email => auth['info']['email'])
    end

    def self.find_or_create_from_google_hash(auth)
        create(:name => auth['name'], :email => auth['email'])
    end

    private
    	def default_values
    		self.smartphone ||= 1
    	end
end
