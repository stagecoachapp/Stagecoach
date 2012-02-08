class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.dummy_user
    
    flash[:success] = "Welcome, #{current_user.name}."
    redirect_to root_url
  end
  
  def destroy
    session[:user_id] = nil
    flash[:info] = "You have successfully logged out"
    redirect_to root_url
  end
  
end
