class HomeController < ApplicationController

  def index
    if self.current_user? && !is_mobile_device?
      render :action => :index_signed_in
      return
    end
      respond_to do |format|
        format.html
      #format.mobile
    end
  end

  def index_signed_in
    respond_to do |format|
      format.mobile
      format.html
    end
  end

  def comingsoon
  	respond_to do |format|
  		format.html
  		format.mobile
  	end
  end

  def about
  end
end

# private
#
#  def is_mobile
#      request.format = :mobile if is_mobile_device?
#   end