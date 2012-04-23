class Asset < ActiveRecord::Base
	attr_accessible :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :asset_object_id, :asset_object_type
	belongs_to :asset_object, :polymorphic => true

	has_attached_file :file, :storage => :s3,
			:s3_credentials => {
					:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
					:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
					:bucket => ENV['S3_BUCKET_NAME']
				},
			:s3_permissions => :private,
    		:path => "/uploads/:asset_object_type/:asset_object_id/:filename"

	validates :file, :attachment_presence => true
	validates :asset_object, :presence => true
end
