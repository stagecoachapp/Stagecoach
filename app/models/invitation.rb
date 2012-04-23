class Invitation < ActiveRecord::Base
 	attr_accessible :to_user, :to_user_id, :from_user, :from_user_id, :subject, :start_date, :end_date, :body, :conversation, :conversation_id, :project, :project_id
 	belongs_to :to_user, :class_name => "User"
 	belongs_to :from_user, :class_name => "User"
 	belongs_to :project
 	has_many :assets, :as => :asset_object, :dependent => :destroy
 	has_one :conversation, :as => :conversation_object

 	def to_s
 		self.project.to_s
 	end
end
