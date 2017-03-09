# Load the Rails application.
require_relative 'application'

############## Our addition #################
 # URL for clearance emails
 # config.action_mailer.default_url_options = { host: 'localhost:3000' }
 config.action_mailer.delivery_method = :smtp
 # SMTP settings for gmail
 config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => 'upselectionapp@gmail.com',
  :password             => 'password1234..',
  :authentication       => "plain",
 :enable_starttls_auto => true
 }
 #############################################
 
# Initialize the Rails application.
Rails.application.initialize!
