class Comment < ActiveRecord::Base
  belongs_to :post

  attr_accessible :commenter, :body, :post_id, :created_at, :updated_at
end
