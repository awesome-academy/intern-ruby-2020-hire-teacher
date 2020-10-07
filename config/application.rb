require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ProjectSun
  class Application < Rails::Application
    config.load_defaults 6.0

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.i18n.load_path += Dir[Rails.root.join("config",
      "locales", "**", "*.{rb,yml}")]

    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi

    config.active_job.queue_adapter = :sidekiq

    config.time_zone = "Hanoi"
    config.active_record.default_timezone = :local
  end
end
