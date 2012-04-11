class User < ActiveRecord::Base
	has_and_belongs_to_many :user_roles
	has_and_belongs_to_many :tasks
	has_and_belongs_to_many :projects
 	has_one :authorization

 	after_initialize :default_values

  def self.create_from_hash!(auth)
    create(:name => auth['info']['name'], :email => auth['info']['email'])
  end

  attr_accessible :name, :email

  def contacts
    contacts = Array.new(10) { iii }
    for project in self.projects
      for user in project
        if user != 
      end
    end
  end

  private
  	def default_values
  		self.smartphone ||= 1
  	end
end
