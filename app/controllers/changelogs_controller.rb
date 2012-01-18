class ChangelogsController < ApplicationController

	def index
		@changelogs = Changelog.find(:all, :order => "created_at DESC")

		respond_to do |format|
		  format.html # index.html.erb
		  format.json { render :json => @changelogs }
		end
	end
end
