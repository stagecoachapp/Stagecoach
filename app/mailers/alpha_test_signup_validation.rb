class AlphaTestSignupValidation < AsyncMailer
	default :from => "#{ENV['GMAIL_USERNAME']}"

	def welcome_email(user_id)
		@user = User.find_by_id(user_id)
		@url  = "http://projectstagecoach.com"
		mail(:to => user.email, :subject => "Welcome to My Awesome Site")
	end
end

