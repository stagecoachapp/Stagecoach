class Invitation < ActiveRecord::Base
 	attr_accessible :to_user, :to_user_id, :from_user, :from_user_id, :subject, :start_date, :end_date, :body
 	has_many :assets
 	belongs_to :to_user, :class_name => "User"
 	belongs_to :from_user, :class_name => "User"
 	has_many :assets, :as => :asset_object, :dependent => :destroy
 	has_one :conversation

 	def to_s
 		self.to_user
 	end
end
