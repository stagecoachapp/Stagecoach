class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_abingo_identity

  def set_abingo_identity
    if (session[:abingo_identity])
      Abingo.identity = session[:abingo_identity]
    else
      session[:abingo_identity] = Abingo.identity = rand(10 ** 10).to_i
    end
  end
end
