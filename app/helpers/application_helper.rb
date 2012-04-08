module ApplicationHelper
    require "sessions_helper"

    def signin_path(provider)
        url = ""
        if provider == :facebook
            url = "/auth/facebook"
        elsif provider == :google
            url = "https://accounts.google.com/o/oauth2/auth?scope="+APP_CONFIG['google_oauth_scope']+
                                                            "&state="+APP_CONFIG['google_oauth_state']+
                                                            "&redirect_uri="+APP_CONFIG['google_oauth_redirect_uri']+
                                                            "&response_type="+APP_CONFIG['google_oauth_response_type']+
                                                            "&client_id="+APP_CONFIG['google_oauth_client_id']+
                                                            "&access_type=offline"
        end
        #return
        url
    end

    def guest_path
        "guest"
    end

    def join_project_path
     "projects/join"
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

end