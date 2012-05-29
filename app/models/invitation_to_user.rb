class InvitationToUser < ActiveRecord::Base
  attr_accessible :invitation_id, :to_user_id
  belongs_to :to_user, :class_name => "User"
  belongs_to :invitation
end
