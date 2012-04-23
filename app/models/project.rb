require 'bcrypt'

class Project < ActiveRecord::Base
	include BCrypt

	my_password = BCrypt::Password.create("my password")

	attr_accessible :name, :created_at, :updated_at, :password_hash, :owner_id, :owner, :administrator, :administrators, :administrator_ids
	has_and_belongs_to_many :users
	has_and_belongs_to_many :administrators, :class_name => "User", :join_table => "administrators"
	belongs_to :owner, :class_name => "User"
	has_many :tasks
	has_many :task_categories
	has_many :user_roles
	has_many :assets, :as => :asset_object, :dependent => :destroy

	validates :name, :presence => true
	validates :owner, :presence => true

	# Next 2 functions provide a layer of abstraction between password and password hash
	def password
      @password ||= Password.new(self.password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

	def capitalized_name
		name.split(' ').map {|w| w.capitalize }.join(' ')
	end

	def owner_exists?
		owner = User.find_by_id(self.owner_id)
		!owner.nil?
	end

end
