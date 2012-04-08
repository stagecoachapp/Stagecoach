class SessionsController < ApplicationController

    require "uri"
    require "open-uri"
    require "net/http"
    require "net/https"
    skip_before_filter :require_login

    def new
        if self.current_user?
            redirect_to root_url
            return
        end

        respond_to do |format|
            format.mobile
            format.html
        end
    end

    #GET  /oauth2callback
    #LOGIC
    #The user is logged in
    #   The current account has no Google account linked
    #       Somebody else has linked this Google account, redirect to root
    #       Nobody has linked the Google account, link it to the current one
    #       User has linked a different Google account, redirect to root
    #The user is not logged in
    #   The Google account has been used before, log them in, redirect to root
    #   The Google account has not been used before, create an account, redirect to edit profile
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
                    hash = JSON.parse(response.body)

                    #user is already logged in. Make sure whichever Facebook they just logged in to isn't attributed to somebody else
                    if self.current_user?
                        #user has either not linked this account yet or is trying to link somebody else's
                        if self.current_user.google_user_information.nil?
                            potential_google_user_information = GoogleUserInformation.find_by_google_hash(hash)
                            #somebody else has liked this Google account
                            unless potential_google_user_information.nil?
                                if potential_google_user_information.user != self.current_user
                                    flash[:error] = "This Google account has already been linked with somebody else"
                                    redirect_to root_url
                                    return
                                end
                            end
                            #they have not linked a Google account and nobody else has linked this one
                            #existing because they are an existing user, not an existing Google account
                            auth_type = 'existing'
                            authorization = GoogleUserInformation.create_from_google_hash(hash, session[:google_refresh_token], self.current_user).user.authorization
                        #the user is already logged in and is logging in again. This shouldn't happen
                        else
                            auth_type = 'existing'
                            authorization = self.current_user.authorization
                            #they are trying to link a second account
                            if authorization.user.google_user_information.google_id != hash['id']
                                flash[:error] = "You have linked a different Google account with this one"
                                redirect_to root_url
                                return
                            end
                        end
                    #user is not logged in yet. Either retrieve the authorization or create a new one and a new user
                    else
                        authorization = GoogleUserInformation.find_by_google_hash(hash)
                        auth_type = 'existing'
                        if authorization.nil?
                            auth_type = 'new'
                            authorization = GoogleUserInformation.create_from_google_hash(hash, session[:google_refresh_token], self.current_user).user.authorization
                        end
                    end

                    google_user_information = GoogleUserInformation.find_or_create_by_google_hash(hash, session[:google_refresh_token], self.current_user)
                    self.current_user= google_user_information.user
                    flash[:success] = "Welcome, #{self.current_user.name}."
                    if session.present?
                        session[:project_id] = current_user.projects.find(:all, :order => "created_at DESC", :limit => 1).first
                    end
                else
                    flash[:error] = "Error logging into gmail"
                end
            else
                flash[:error] = "Error logging into gmail"
            end
        else
            flash[:error] = "Error logging into gmail"
        end
        if auth_type = 'new' && is_mobile_device?
            redirect_to edit_user_url(self.current_user)
            return
        end
        redirect_to root_url
    end

    #GET /auth/:provider/callback
    #LOGIC
    #The user is logged in
    #   The Facebook account is not linked to the current account
    #       There is another account linked to that Facebook account, redirect to root
    #       There is no Facebook linked to the current account, create an authorization
    #       There is a different Facebook account linked to this one, ignore new authorization, redirect to root
    #The user is not logged in
    #   This Facebook has been used before, log them in
    #   This Facebook has never been used before, make a new user and log them in

    def create_facebook
        hash = request.env['omniauth.auth']
        #user is already logged in. Make sure whichever Facebook they just logged in to isn't attributed to somebody else
        if self.current_user?
            #user has either not linked this account yet or is trying to link somebody else's
            if self.current_user.authorization.uid != hash['uid']
                potential_authorization = Authorization.find_by_facebook_hash(hash)
                #somebody else has liked this Facebook account
                unless potential_authorization.nil?
                    if potential_authorization.user != self.current_user
                        flash[:error] = "This Facebook account has already been linked with somebody else"
                        redirect_to root_url
                        return
                    #this shouldn't happen but there is an authorization with that Facebook linked to the current account
                    #but the current account isn't linked to that Facebook
                    else
                        potential_authorization.update_attribute(:user, user)
                    end
                end
                #user has not linked a Facebook yet
                if self.current_user.authorization.uid.nil?
                    #existing because they are an existing user, not an existing Facebook account
                    auth_type = 'existing'
                    authorization = Authorization.create_from_facebook_hash(hash, self.current_user)
                #user has linked a difference Facebook
                else
                    flash[:error] = "You have linked a different Facebook to this account"
                    redirect_to root_url
                    return
                end
            #the user is already logged in and is logging in again. This shouldn't happen
            else
                auth_type = 'existing'
                authorization = self.current_user.authorization
            end
        #user is not logged in yet. Either retrieve the authorization or create a new one and a new user
        else
            authorization = Authorization.find_by_facebook_hash(hash)
            auth_type = 'existing'
            if authorization.nil?
                auth_type = 'new'
                authorization = Authorization.create_from_facebook_hash(hash)
            end
            # Log the authorizing user in.
            self.current_user= authorization.user
        end

        flash[:success] = "Welcome, #{self.current_user.name}."
        if session.present?
            session[:project_id] = current_user.projects.find(:all, :order => "created_at DESC", :limit => 1).first
        end

        #only edit profile if mobile because this functionality isn't build out on the front end yet
        if auth_type == 'new' && is_mobile_device?
            redirect_to edit_user_url(current_user)
            return
        end
        redirect_to root_url
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
