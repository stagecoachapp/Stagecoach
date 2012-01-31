class Task < ActiveRecord::Base
  validates :task, :presence => true
  validates :assigned_to, :presence => true
  validates :assigned_by, :presence => true
end
