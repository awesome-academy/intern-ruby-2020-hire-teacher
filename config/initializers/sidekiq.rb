require "resolv-replace"
REDIS_SERVER_CONFIG = Rails.application.config
  .database_configuration[Rails.env]["redis"]
REDIS_HOST = REDIS_SERVER_CONFIG["host"]
REDIS_PORT = REDIS_SERVER_CONFIG["port"]
REDIS_DB = REDIS_SERVER_CONFIG["db"]

Sidekiq::Extensions.enable_delay!

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{REDIS_HOST}:#{REDIS_PORT}/12",
    network_timeout: 5,
    password: "YVr7JafHf7IeZkVsbRjgBadlUnm1tI1LrbB/4RZvQxnWIm4GPB7lPFXoDKhFSzKPfM6R7hrzFj6XwcEv"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://127.0.0.1:#{REDIS_PORT}/12",
    network_timeout: 5,
    password: "YVr7JafHf7IeZkVsbRjgBadlUnm1tI1LrbB/4RZvQxnWIm4GPB7lPFXoDKhFSzKPfM6R7hrzFj6XwcEv"
  }
end
