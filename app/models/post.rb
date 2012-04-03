class Post < ActiveRecord::Base
  validates :name, :presence => true
  validates :title, :presence => true,
  :length => { :minimum => 5 }

  has_many :comments
  has_many :tags

  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  def to_param
  	#this changes the url to the title of the post with the id in it-- !!the id is necessary for this to work!!
    "#{id}-#{title.parameterize}"
  end
end
