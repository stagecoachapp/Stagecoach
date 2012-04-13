class User < ActiveRecord::Base
    has_and_belongs_to_many :user_roles
    has_and_belongs_to_many :tasks
    has_and_belongs_to_many :projects
    has_and_belongs_to_many :conversations
    has_one :authorization
    has_many :notifications
    has_many :messages
    has_one :google_user_information
    attr_accessible :name, :email
    after_initialize :default_values

    def self.create_from_facebook_hash!(hash)
        create(:name => hash['info']['name'], :email => hash['info']['email'])
    end

    def self.create_from_google_hash(hash)
        create(:name => hash['name'], :email => hash['email'])
    end

    def linked_facebook?
        if self.authorization.nil?
            false
            return
        end
        !self.authorization.uid.nil?
    end

    def linked_google?
        !self.google_user_information.nil?
    end

    private
    def default_values
      self.smartphone ||= 1
  end
end
