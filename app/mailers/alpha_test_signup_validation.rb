class AlphaTestSignupValidation < AsyncMailer
	default :from => "#{ENV['GMAIL_USERNAME']}"

	def welcome_email(signup_id)
		@signup = Signup.find_by_id(signup_id)
		@url  = "http://projectstagecoach.com"
		mail(:to => @signup.email, :subject => "Welcome to My Awesome Site")
	end
end

