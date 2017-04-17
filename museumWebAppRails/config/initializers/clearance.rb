Clearance.configure do |config|
  #These are the configuration settings we are using from the clearance gem
  config.routes = false
  config.mailer_sender = "LelooskaSensorWebsite@gmail.com"
  #config.mailer_sender = "reply@example.com"
  #config.allow_sign_up = true
  #config.cookie_domain = "gmail.com"
  #config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  #config.cookie_name = "remember_token"
  #config.cookie_path = "/"
  #config.routes = false
  #config.httponly = false
  config.mailer_sender = "LelooskaSensorWebsite@gmail.com"
  #config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = RAILS_RELATIVE_URL_ROOT
  #config.rotate_csrf_on_sign_in = false
  #config.secure_cookie = false
  #config.sign_in_guards = []
  #config.user_model = User
end
