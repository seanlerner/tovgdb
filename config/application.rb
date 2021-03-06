# Rails
require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Load local environment
require 'dotenv'
root = '~/.local/tovgdb'
Dotenv.load(
  File.join(root, '.env'),
  File.join(root, '.env.local'),
  File.join(root, ".env.#{Rails.env}")
)

# Elastic Search
require 'elasticsearch/rails/instrumentation'

Bundler.require(*Rails.groups)

module Tovgdb
  class Application < Rails::Application
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Not using default testing
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.view_specs      false
      g.helper_specs    false
    end

    # Debugging
    config.action_controller.action_on_unpermitted_parameters = :raise

    # Email
    config.action_mailer.default_url_options = { only_path: true }
  end
end
