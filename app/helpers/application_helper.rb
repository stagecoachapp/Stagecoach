module ApplicationHelper

  def signin_path(provider)
    "auth/#{provider.to_s}"
  end

  def guest_path
    "guest"
  end

  def join_project_path
  	"projects/join"
  end

end
