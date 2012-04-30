class EmailSetting < ActiveRecord::Base
  attr_accessible :user, :user_id, :new_task, :new_invitation
  belongs_to :user
end
