class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new]

  def new
    debugger
    @user = current_user
  end
end
