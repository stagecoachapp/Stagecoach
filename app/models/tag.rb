class Tag < ActiveRecord::Base
  attr_accessible :name, :post_id, :created_at, :updated_at
  belongs_to :post

end
