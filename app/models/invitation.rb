class Invitation < ActiveRecord::Base
 	attr_accessible :to_user, :to_user_ids, :from_user, :from_user_id, :subject, :start_date, :end_date, :body, :conversation, :conversation_id, :project, :project_id
 	has_many :invitation_to_users
 	has_many :to_users, :through => :invitation_to_users
 	belongs_to :from_user, :class_name => "User"
 	belongs_to :project
 	has_many :assets, :as => :asset_object, :dependent => :destroy
 	has_one :conversation, :as => :conversation_object

 	validates :to_users, :presence => true

 	def to_s(user=nil)
 		if(self.to_users.include?(user))
 			self.from_user.from_user +"invited you to join "+self.project.to_s
 		elsif(self.from_user == user)
 			"Invited "+join(self.to_users.map {|to_user| to_user.name})+" to join "+self.project.to_s
 		else
 			self.from_user.to_s +" invited "+join(self.to_users.map {|to_user| to_user.name})+" to join"+self.project.to_s
 		end
 	end

 	def incoming_to_s
 		self.from_user.to_s+" invited you to join "+self.project.to_s
 	end

 	def outgoing_to_s
 		"Invited "+join(self.to_users.map {|to_user| to_user.name})+" to "+self.project.to_s
 	end


 	private
	 	def join(arr)
		    return '' if not arr
		    case arr.size
		        when 0 then ''
		        when 1 then arr[0]
		        when 2 then arr.join(' and ')
		        else arr[0..-2].join(', ') + ', and ' + arr[-1]
		    end
		end
end
