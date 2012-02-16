class HomeController < ApplicationController
  
  def index
    respond_to do |format|
      format.html
      #format.mobile
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