class EmailSetting < ActiveRecord::Base
  attr_accessible :user, :user_id, :new_task, :new_invitation, :new_asset
  belongs_to :user
end
