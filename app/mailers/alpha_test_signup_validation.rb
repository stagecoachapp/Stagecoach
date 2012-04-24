class AlphaTestSignupValidation < ActionMailer::Base
	default :from => "#{ENV['GMAIL_USERNAME']}"

	def welcome_email(user)
		@user = user
		@url  = "http://projectstagecoach.com"
		mail(:to => user.email, :subject => "Welcome to My Awesome Site")
	end
end

