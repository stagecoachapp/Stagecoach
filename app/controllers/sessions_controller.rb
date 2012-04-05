class SessionsController < ApplicationController

    require "uri"
    require "open-uri"
    require "net/http"
    require "net/https"
    skip_before_filter :require_login

    def new
        respond_to do |format|
            format.html
        end
    end

    #GET  /oauth2callback
    def create_google

        #successfully received access code
        if !params["code"].nil?
            #send a post request with the temporary authorization code to get the long term access token
            post_params = {"code" => params["code"],
                            "client_id" => APP_CONFIG['google_oauth_client_id'],
                            "client_secret" => APP_CONFIG['google_oauth_client_secret'],
                            "redirect_uri" => APP_CONFIG['google_oauth_redirect_uri'],
                            "grant_type" => "authorization_code"}
            uri = URI.parse("https://accounts.google.com/o/oauth2/token")
            http = Net::HTTP.new(uri.host, uri.port)
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            http.use_ssl = true
            request = Net::HTTP::Post.new(uri.request_uri)
            request["Content-Type"] = "application/x-www-form-urlencoded"
            request.body = post_params.to_query
            response = http.request(request)
            #successfully received authorization token
            if response.code == "200"
                session[:google_access_token] = JSON.parse(response.body)["access_token"]
                session[:google_refresh_token] = JSON.parse(response.body)["refresh_token"]
                uri = URI.parse("https://www.googleapis.com/oauth2/v2/userinfo")
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE
                path = "/oauth2/v2/userinfo"
                header = { "Authorization" => "OAuth "+session[:google_access_token] }
                response = http.get(path, header)
                #successfully received userinfo
                if response.code == "200"
                    response_hash = JSON.parse(response.body)
                    #the third parameter is the current user which is nil because they are signing in now

                    google_user_information = GoogleUserInformation.find_or_create_by_google_id(response_hash, session[:google_refresh_token], nil)
                    self.current_user= google_user_information.user
                    flash[:success] = "Welcome, #{self.current_user.name}."
                else
                    flash[:error] = "Error logging into gmail"
                end
            else
                flash[:error] = "Error logging into gmail"
            end
        else
            flash[:error] = "Error logging into gmail"
        end
        redirect_to root_url
    end

    #GET /auth/:provider/callback
    def create_facebook
        auth = request.env['omniauth.auth']
        auth_type = 'existing'
        if !(@auth = Authorization.find_from_facebook_hash(auth))
            # Create a new user or add an auth to existing user, depending on
            # whether there is already a user signed in.
            auth_type = 'new'
            @auth = Authorization.create_from_facebook_hash(auth, current_user)
        end
            # Log the authorizing user in.
            self.current_user=(@auth.user)
            if !is_mobile_device?
              flash[:success] = "Welcome, #{self.current_user.name}."
            end
            if session.present?
                session[:project_id] = current_user.projects.find(:all, :order => "created_at DESC", :limit => 1).first
            end

            if auth_type == 'new'
                redirect_to edit_user_url(current_user)
            else
                redirect_to root_url
            end
    end

    def guest
        @user = User.find_by_name("Guest")
        if(@user.nil?)
            @user = User.new(:name => "Guest", :email => "guest@stagecoach.com" )
            @user.save
        end

        self.current_user=(@user)

        self.current_project= self.current_user.projects.find(:all, :order => "created_at DESC", :limit => 1).first
        redirect_to root_url
    end

    def destroy
        session[:user_id] = nil
        session[:project_id] = nil
        if !is_mobile_device?
            flash[:info] = "You have successfully logged out"
        end
        redirect_to root_url
    end

end
