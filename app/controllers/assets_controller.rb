class AssetsController < ApplicationController

	#GET /assets
	def index

		@assets = self.current_project.assets

		respond_to do |format|
			format.html
		end

	end

	#GET /assets/upload
	def new
		@asset = Asset.new

		respond_to do |format|
			format.html
		end
	end

	#POST /assets
	def create
		@asset = Asset.new(params[:asset])
		@asset.asset_object = self.current_project

		if @asset.save
			flash[:success] = 'File successfully uploaded'
		else
			flash[:error] = 'File upload error'
		end
		redirect_to :action => :index
	end

	def show
		#asset = Asset.find(params[:asset])
		respond_to do |format|
			redirect_to root_url #asset.file_file_path
		end
	end

end
