class Comment < ActiveRecord::Base
  attr_accessible :commenter, :body, :post_id, :created_at, :updated_at
  belongs_to :post

end
