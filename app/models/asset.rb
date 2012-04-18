class Asset < ActiveRecord::Base
	attr_accessible :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :asset_object_id, :asset_object_type
	belongs_to :asset_object, :polymorphic => true

	has_attached_file :file, :storage => :s3,
			:s3_credentials => "#{Rails.root}/config/s3.yml",
			:s3_permissions => :private,
    		:path => "/uploads/:asset_object_type/:asset_object_id/:filename"

	validates :file, :attachment_presence => true
	validates :asset_object, :presence => true
end
