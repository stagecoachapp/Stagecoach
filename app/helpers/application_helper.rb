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
    "/tasks/menu"
end

def project_menu_path
    "/projects/menu"
end

def comingsoon_path
    "/comingsoon"
end

def notifications_path
    "/notifications"
end

def assets_path(asset="")
    "/assets/#{asset.id rescue ''}"
end

def upload_assets_path
    "/assets/upload"
end

def other_projects
    return Array(Array(self.current_user.projects.all).select { |project| project != self.current_project })
end

def extra_header_notification_badge_classes
    if self.unread_notification_count > 0
        return "badge-error"
    end
    ""
end

def profile_picture_url user=nil
    if user.nil?
        if self.current_user.linked_facebook? && !self.current_user.facebook_user_information.profile_picture.nil?
            url = self.current_user.facebook_user_information.profile_picture
        elsif self.current_user.linked_google? && !self.current_user.google_user_information.profile_picture.nil?
            url = self.current_user.google_user_information.profile_picture
        else
            url = "/assets/header/default_profile_picture.png"
        end
        return url
    end
    if user.linked_facebook? && !user.facebook_user_information.profile_picture.nil?
        url = user.facebook_user_information.profile_picture
    elsif user.linked_google? && !user.google_user_information.profile_picture.nil?
        url = user.google_user_information.profile_picture
    else
        url = "/assets/header/default_profile_picture.png"
    end
    return url
end
end
