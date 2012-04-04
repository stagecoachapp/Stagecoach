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
