class Message < ActiveRecord::Base
  attr_accessible :conversation_id, :from, :text, :type
  belongs_to :conversation
  belongs_to :user
end
