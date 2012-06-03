class AssetsController < ApplicationController

	#GET /assets
	def index

		@assets = Asset.all()
		@title = "Assets"
		# Fix This
		#@assets = self.current_project.assets

		respond_to do |format|
			format.html
		end

	end

	#GET /assets/upload
	def new
		@asset = Asset.new
		@title = "Upload Asset"
		respond_to do |format|
			format.html
		end
	end

	#POST /assets
	def create
		@asset = Asset.new(params[:asset])
		@asset.asset_object = self.current_project

		if @asset.save
			if @asset.asset_object.class.name == "Project"
				self.current_project.users.each do |user|
					Notification.create(notification_type: NotificationType.find_by_name("NewProjectAsset"), user: user, notification_object: @asset);
				end
			end
			flash[:success] = 'File successfully uploaded'
		else
			flash[:error] = 'File upload error'
		end
		redirect_to :action => :index
	end

	#GET /asset/:id
	def show
		@asset = Asset.find_by_id(params[:id])
		@title = "Assets"
		if @asset.asset_object_type == "Project"
			if  @asset.asset_object_id == self.current_project.id
				object_key = @asset.file.to_s.split('/',5).last
				object_key = object_key.split('?').first
				s3 = AWS::S3.new
				s3_object = s3.buckets[ENV['S3_BUCKET_NAME']].objects[object_key]
				url =  s3_object.url_for(:read, :expires => 60)
				redirect_to url.to_s
				return
			end
		end
		redirect_to :back
	end

end
