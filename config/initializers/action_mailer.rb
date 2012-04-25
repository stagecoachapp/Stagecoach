ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "projectstagecoach.com",
  :user_name            => "admin@projectstagecoach.com",
  :password             => "northwestern2013",
  :authentication       => "plain",
  :enable_starttls_auto => true
}


ActionMailer::Base.default_url_options[:host] = "projectstagecoach.com"