class ChangelogsController < ApplicationController

	def index
		@changelogs = Changelog.all

		respond_to do |format|
		  format.html # index.html.erb
		  format.json { render :json => @changelogs }
		end
	end
end
