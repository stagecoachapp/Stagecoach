s3_credentials = YAML.load_file("config/s3.yml")[Rails.env]
AWS.config(
	:access_key_id     => s3_credentials["access_key_id"],
	:secret_access_key => s3_credentials["secret_access_key"]
)