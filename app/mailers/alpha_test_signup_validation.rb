class AlphaTestSignupValidation < AsyncMailer
	default :from => "admin@projectstagecoach.com"

	def welcome_email(signup_id)
		@signup = Signup.find_by_id(signup_id)
		@url  = "http://projectstagecoach.com"
		message = mail(:to => @signup.email, :subject => "Welcome to My Awesome Site")
		message.delivery_method.settings.merge!({:user_name => "admin@projectstagecoach.com"})
	end
end

