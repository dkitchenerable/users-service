require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module UsersService
  class Application < Rails::Application
    config.api_only = true
    config.active_job.queue_adapter = :sidekiq
    ENV["API_SERVICE_ENDPOINT"] = "https://account-key-service.herokuapp.com/v1/account"
    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }
  end
end
