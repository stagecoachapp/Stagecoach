module ApplicationHelper

  def signin_path(provider)
    "auth/#{provider.to_s}"
  end

  def guest_path
    "guest"
  end

end
