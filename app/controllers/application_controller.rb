class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :choose_layout

  protected
    def choose_layout
      url = request.path
      if (url == phone_path)  
        return 'phone'
      else
        return 'application'
      end
    end
  end
