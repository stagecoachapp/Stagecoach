class InvitationMailer < AsyncMailer
  default from: "admin@projectstagecoach.com"

	def invite(from_name, to_name, to_email, body)
		@from_name = from_name
		@to_name = to_name
		@body = body
		mail(:to => to_email, :subject => "#{from_name} has invited you to join Stagecoach!")
	end
end
