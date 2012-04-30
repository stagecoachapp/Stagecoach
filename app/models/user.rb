class User < ActiveRecord::Base
    attr_accessible :name, :email, :phonenumber, :user_role_ids, :smartphone, :activated, :email_setting, :email_setting_id
    has_and_belongs_to_many :user_roles
    has_and_belongs_to_many :tasks
    has_and_belongs_to_many :projects
    has_one :authorization
    has_many :notifications, :dependent => :destroy
    has_one :google_user_information
    has_one :email_setting
    after_initialize :default_values
    before_save :lowercase_name

    def self.create_from_facebook_hash(hash)
        create(:name => hash['info']['name'], :email => hash['info']['email'], :email_setting => EmailSetting.create)
    end

    def self.create_from_google_hash(hash)
        create(:name => hash['name'], :email => hash['email'], :email_setting => EmailSetting.create)
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


    def contacts
        contacts = []
        for project in self.projects
          for potential_contact in project.users
            unless potential_contact == self
              unless contacts.include?(potential_contact)
                contacts << potential_contact
              end
            end
          end
        end
        contacts.sort_by! {|c| c.name}
        return contacts
    end

    def to_s
        self.name
    end

    def name
    	read_attribute(:name).split(' ').map {|w| w.capitalize }.join(' ')
    end

    private
		def default_values
			self.smartphone ||= 1
		end

		def lowercase_name
			self.name  = self.name.downcase
		end
end
