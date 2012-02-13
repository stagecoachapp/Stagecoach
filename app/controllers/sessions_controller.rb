class SessionsController < ApplicationController
skip_before_filter :require_login

  def new

    respond_to do |format|
      format.html
    end

  end

  def create
    auth = request.env['omniauth.auth']
    auth_type = 'existing'
    if !(@auth = Authorization.find_from_hash(auth))
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      auth_type = 'new'
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    sign_in(@auth.user)
    if !is_mobile_device?
      flash[:success] = "Welcome, #{current_user.name}."
    end

    if auth_type == 'new'
      redirect_to new_user_url
    else
      redirect_to root_url
    end
  end

  def guest
    @user = User.new(:name => "Guest", :email => "guest@stagecoach.com" )
    if @user.save
      sign_in(@user)
    end
    render 'home/index'
  end
  
  def destroy
    session[:user_id] = nil
    if !is_mobile_device?
      flash[:info] = "You have successfully logged out"
    end
    redirect_to root_url
  end
  
end
