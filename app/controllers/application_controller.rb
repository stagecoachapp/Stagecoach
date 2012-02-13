class ApplicationController < ActionController::Base
  protect_from_forgery
  
  has_mobile_fu
  before_filter :set_request_format
  def set_request_format
    request.format = :mobile if is_mobile_device?
  end
  
  before_filter :set_abingo_identity
  def set_abingo_identity
    if (session[:abingo_identity])
      Abingo.identity = session[:abingo_identity]
    else
      session[:abingo_identity] = Abingo.identity = rand(10 ** 10).to_i
    end
  end


  before_filter :require_login
  def require_login
    unless signed_in?
      if is_mobile_device?
        redirect_to '/signin'
      end
    end
  end
  
  #Authorization stuff
  protected
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
    def signed_in?
      !!current_user
    end
    def current_user=(user)
      @current_user = user
      session[:user_id] = user.id
    end
    helper_method :current_user, :signed_in?
  #End authorization stuff
  
end
