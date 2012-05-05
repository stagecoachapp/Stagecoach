class FacebookUserInformation < ActiveRecord::Base
  attr_accessible :user, :user_id, :uid, :email, :name, :profile_picture, :location_id, :token, :expires_at, :expires, :gender
  belongs_to :user
end
