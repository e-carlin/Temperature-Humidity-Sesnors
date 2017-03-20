Clearance.configure do |config|
<<<<<<< HEAD
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
=======
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
  #config.redirect_url = "/"
  #config.rotate_csrf_on_sign_in = false
  #config.secure_cookie = false
  #config.sign_in_guards = []
  #config.user_model = User
>>>>>>> a69cf63e80dfac21d11bd85663e03b9722eecdef
end
