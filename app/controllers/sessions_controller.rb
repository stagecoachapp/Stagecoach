class SessionsController < ApplicationController

    require "uri"
    require "open-uri"
    require "net/http"
    require "net/https"
    skip_before_filter :require_login
    def new
        if self.current_user?
            redirect_after_login
            return
        end

        respond_to do |format|
            format.mobile
            format.html
        end
    end

    def redirect_after_login
        if session[:after_login_redirect_url].nil?
           redirect_to root_url
        else
            redirect_to session[:after_login_redirect_url]
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
                "client_id" => ENV['GOOGLE_OAUTH_CLIENT_ID'],
                "client_secret" => ENV['GOOGLE_OAUTH_CLIENT_SECRET'],
                "redirect_uri" => ENV['GOOGLE_OAUTH_REDIRECT_URI'],
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
                            potential_google_user_information = GoogleUserInformation.find_by_hash(hash)
                            #somebody else has liked this Google account
                            unless potential_google_user_information.nil?
                                if potential_google_user_information.user != self.current_user
                                    flash[:error] = "This Google account has already been linked with somebody else"
                                    redirect_after_login
                                    return
                                end
                            end
                            #they have not linked a Google account and nobody else has linked this one
                            #existing because they are an existing user, not an existing Google account
                            auth_type = 'existing'
                            self.current_user.link_google(hash, session[:google_refresh_token])
                            GoogleUserInformation.create_from_hash(hash, session[:google_refresh_token], self.current_user)
                        #the user is already logged in and is logging in again. This shouldn't happen
                        else
                            auth_type = 'existing'
                            if self.current_user.google_user_information.nil?
                                self.current_user.link_google(hash, session[:google_refresh_token])
                            end
                            #they are trying to link a second account
                            if self.current_user.google_user_information.google_id != hash['id']
                                flash[:error] = "You have linked a different Google account with this one"
                                redirect_after_login
                                return
                            end
                        end
                    #user is not logged in yet. Either retrieve the user or create a new user
                    else
                        google_user_information = GoogleUserInformation.find_by_hash(hash)
                        auth_type = 'existing'
                        if google_user_information.nil?
                            auth_type = 'new'
                            user = User.create_from_google_hash(hash, session[:google_refresh_token])
                        end
                    end

                    google_user_information = GoogleUserInformation.find_or_create_by_hash(hash, session[:google_refresh_token], self.current_user)
                    self.current_user= google_user_information.user
                    flash[:success] = "Welcome, #{self.current_user.name}."
                    if session.present?
                        session[:project_id] = current_user.projects.find(:all, :order => "created_at DESC", :limit => 1).first
                    end
                else
                    #error in 2nd google callback
                    flash[:error] = "Error logging into gmail"
                end
            else
                #error in 1st google callback
                flash[:error] = "Error logging into gmail"
            end
        else
            #error receiving access code
            flash[:error] = "Error logging into gmail"
        end
        if auth_type == 'new' && is_mobile_device?
            redirect_to edit_user_url(self.current_user)
            return
        end
        redirect_after_login
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

             if self.current_user.linked_facebook?
                #already linked to facebook?
                flash[:error] = "Your account is already linked to Facebook"
                redirect_to root_url
                return
            else
                 potential_facebook_user_information = FacebookUserInformation.find_by_hash(hash)
                 #nobody has linked this facebook yet
                 if potential_facebook_user_information.nil?
                     self.current_user.link_facebook(hash)
                     facebook_user_information = self.current_user.facebook_user_information
                 else
                    flash[:error] = "Somebody else has linked this Facebook"
                    redirect_to root_url
                    return
                end
            end
        #user is not logged in yet. Either retrieve the authorization or create a new one and a new user
        else
            facebook_user_information = FacebookUserInformation.find_by_hash(hash)
            auth_type = 'existing'
            if facebook_user_information.nil?
                auth_type = 'new'
                facebook_user_information = FacebookUserInformation.create_from_hash(hash)
            else
                #This Facebook account is linked to a user that doesn't exist
                if facebook_user_information.user.nil?
                    user = User.create_from_facebook_hash(hash)
                    facebook_user_information.update_attribute(:user, user)
                end
            end
            # Log the authorizing user in.
            self.current_user= facebook_user_information.user
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
        redirect_after_login
    end

    def guest
        @user = User.find_by_name("guest")
        if(@user.nil?)
            @user = User.new(:name => "Guest", :email => "guest@stagecoach.com" )
            @user.save
        end

        self.current_user=(@user)

        self.current_project= self.current_user.projects.find(:all, :order => "created_at DESC", :limit => 1).first
        redirect_after_login
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
