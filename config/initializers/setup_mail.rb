ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "nomid21",
  :password             => "0953326461",
  :authentication       => "plain",
  :enable_starttls_auto => true
}