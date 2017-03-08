Clearance.configure do |config|
  config.allow_sign_up = true
  #This will be our domain
  config.cookie_domain = "localhost:3000"
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.cookie_name = "remember_token"
  config.cookie_path = "/"
  config.routes = true
  config.httponly = false
  config.mailer_sender = "mgilbert311@gmail.com"
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = "/"
  #config.rotate_csrf_on_sign_in = false
  config.secure_cookie = false
  #config.sign_in_guards = []
  config.user_model = User
end
