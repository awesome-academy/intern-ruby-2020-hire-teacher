Devise.setup do |config|
  config.scoped_views = true
  config.mailer_sender = ENV["host"]
  require "devise/orm/active_record"
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.lock_strategy = :failed_attempts
  config.unlock_keys = [ :email ]
  config.unlock_strategy = :both
  config.maximum_attempts = 5
  config.unlock_in = 1.minutes
  config.last_attempt_warning = true
  config.omniauth :google_oauth2, ENV["GOOGLE_OAUTH2_APP_ID"], ENV["GOOGLE_OAUTH2_APP_SECRET"], { scope: "email" }
  config.omniauth :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_APP_SECRET"], { scope: "email" }
  config.omniauth :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"], scope: "user:emails, read:org"
end
