class HomeController < ApplicationController

  def index
   @signup = Signup.new
   if self.current_user? && !is_mobile_device?
    index_signed_in
    render :action => :index_signed_in
    return
  end
  respond_to do |format|
    format.html
      #format.mobile
    end
  end

  def index_signed_in
    if self.current_project.nil?
      @no_project = true
    else
      if self.current_project.users.count == 1
        @empty_project = true
      else
        if self.current_project.tasks.count == 0
          @no_tasks = true
        end
      end
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