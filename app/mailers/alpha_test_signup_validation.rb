class AlphaTestSignupValidation < ActionMailer::Base
	default :from => "notifications@projectstagecoach.com"

	def welcome_email(user)
		@user = user
		@url  = "http://projectstagecoach.com"
		mail(:to => user.email, :subject => "Welcome to My Awesome Site")
	end
end

