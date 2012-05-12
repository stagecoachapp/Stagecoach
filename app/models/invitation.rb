class Invitation < ActiveRecord::Base
 	attr_accessible :to_user, :to_user_id, :from_user, :from_user_id, :subject, :start_date, :end_date, :body, :conversation, :conversation_id, :project, :project_id
 	belongs_to :to_user, :class_name => "User"
 	belongs_to :from_user, :class_name => "User"
 	belongs_to :project
 	has_many :assets, :as => :asset_object, :dependent => :destroy
 	has_one :conversation, :as => :conversation_object

 	def to_s(user=nil)
 		case user
 		when self.to_user
 			self.from_user.to_s +"invited you to join "+self.project.to_s
 		when self.from_user
 			"Invited "+self.to_user.to_s+" to join "+self.project.to_s
 		else
 			self.from_user.to_s +" invited "+self.to_user.to_s+" to join"+self.project.to_s
 		end
 	end

 	def incoming_to_s
 		self.from_user.to_s+" invited you to join "+self.project.to_s
 	end

 	def outgoing_to_s
 		"Invited "+self.to_user.to_s+" to "+self.project.to_s
 	end
end
