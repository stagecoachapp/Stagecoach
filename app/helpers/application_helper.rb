module ApplicationHelper
    require "sessions_helper"

    def signin_path(provider)
        url = ""
        if provider == :facebook
            url = "/auth/facebook"
        elsif provider == :google
            url = "https://accounts.google.com/o/oauth2/auth?scope="+ENV['GOOGLE_OAUTH_SCOPE']+
                                                            "&state="+ENV['GOOGLE_OAUTH_STATE']+
                                                            "&redirect_uri="+ENV['GOOGLE_OAUTH_REDIRECT_URI']+
                                                            "&response_type="+ENV['GOOGLE_OAUTH_RESPONSE_TYPE']+
                                                            "&client_id="+ENV['GOOGLE_OAUTH_CLIENT_ID']+
                                                            "&access_type=offline"
        end
        #return
        url
    end

    def guest_path
        "guest"
    end

    def join_project_path
     "/projects/join"
    end

    def task_menu_path
     "tasks/menu"
    end

    def project_menu_path
        "projects/menu"
    end

    def comingsoon_path
        "comingsoon"
    end

    def notifications_path
        "notifications"
    end

    def upload_assets_path
        "/assets/upload"
    end

end
