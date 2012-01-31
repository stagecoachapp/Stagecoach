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
end
