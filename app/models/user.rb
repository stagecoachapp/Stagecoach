class User < ActiveRecord::Base
  attr_accessible :name, :email
  has_and_belongs_to_many :user_roles
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :projects
  has_one :authorization
  has_many :notifications

  after_initialize :default_values

  def self.create_from_hash!(auth)
    create(:name => auth['info']['name'], :email => auth['info']['email'])
  end


  private
  	def default_values
  		self.smartphone ||= 1
  	end
end
