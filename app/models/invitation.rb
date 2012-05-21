class Invitation < ActiveRecord::Base
 	attr_accessible :to_user, :to_user_ids, :from_user, :from_user_id, :subject, :start_date, :end_date, :body, :conversation, :conversation_id, :project, :project_id
 	has_many :invitation_to_users
 	has_many :to_users, :through => :invitation_to_users
 	belongs_to :from_user, :class_name => "User"
 	belongs_to :project
 	has_many :assets, :as => :asset_object, :dependent => :destroy
 	has_one :conversation, :as => :conversation_object

 	validates :to_user, :presence => true

 	def to_s
 		"Invited "+self.to_user.to_s+" to "+self.project.to_s
 	end
end
