if ENV['COVERAGE'] # Use 'COVERAGE=true rspec' to generate coverage report
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter 'spec/rails_helper'
    add_filter 'lib/webkit_stderr_with_qt_plugin_messages_suppressed'
  end
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'devise'
require 'capybara/rspec'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include Warden::Test::Helpers
  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise(<<-MSG)
        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the app-under-test that the browser driver connects to
        uses a different database connection to the database connection used by
        the spec. The app's database connection would not be able to access
        uncommitted transaction data setup over the spec's database connection.
      MSG
    end
    Warden.test_mode!
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test
    unless driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.after :each do
    Warden.test_reset!
  end

  # For testing Videos on games with YouTube embeds
  Capybara::Webkit.configure do |capybara_config|
    capybara_config.allow_url('www.youtube.com')
    capybara_config.allow_url('s.ytimg.com')
    capybara_config.allow_url('www.google.com')
    capybara_config.allow_url('static.doubleclick.net')
  end
end
