class ChangelogsController < ApplicationController

	def index
		@changelogs = Changelog.find(:all, :order => "created_at DESC")

		if is_mobile_device?
			@header = "Changelog"
		end
		respond_to do |format|
		  format.html # index.html.erb
		  format.mobile
		  format.json { render :json => @changelogs }
		end
	end
end
