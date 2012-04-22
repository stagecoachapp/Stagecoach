class TaskStatus < ActiveRecord::Base
  attr_accessible :name
  has_many :tasks

  def to_s
  	self.name
  end

end
