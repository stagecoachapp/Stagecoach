class ApplicationController < ActionController::Base
    protect_from_forgery


    has_mobile_fu
    before_filter :set_request_format
    def set_request_format
        request.format = :mobile if is_mobile_device?
    end

    before_filter :set_abingo_identity
    def set_abingo_identity
        if (session[:abingo_identity])
            Abingo.identity = session[:abingo_identity]
        else
            session[:abingo_identity] = Abingo.identity = rand(10 ** 10).to_i
        end
    end


    before_filter :require_login
    def require_login
        unless current_user?
            if is_mobile_device?
                redirect_to '/signin'
            end
        end
    end

    protected
        def current_user
            @current_user ||= User.find_by_id(session[:user_id])
        end
        def current_project
            @current_project  ||= session[:project_id]
        end
        def current_project=(project_id)
            session[:project_id] = Project.find_by_id(project_id)
            @current_project = session[:project_id]
        end
        def current_user?
            !!current_user
        end
        def current_user=(user)
            @current_user = user
            session[:user_id] = user.id
        end

        def connected_to_facebook?
            if !current_user?
                return false
            end
            if current_user.authorization.nil?
                return false
            end
            if !current_user.authorization.uid.nil?
                return true
            end
            return false
        end

        def connected_to_google?
            if !current_user?
                return false
            end
            if current_user.authorization.nil?
                return false
            end
            if !current_user.google_user_information.nil?
                return true
            end
            return false
        end

        def google_api(url, params="", security=OpenSSL::SSL::VERIFY_NONE)
            uri = URI.parse(url)
            http = Net::HTTP.new(uri.host, uri.port)
            http.verify_mode = security
            http.use_ssl = true
            request = Net::HTTP::Get.new(uri.request_uri)
            request["Content-Type"] = "application/x-www-form-urlencoded"
            request.body = params.to_query
            response = http.request(request)
        end

        helper_method :current_user, :current_user?, :current_user=, :current_project, :current_project=, :google_api, :connected_to_google?, :connected_to_facebook?

end
