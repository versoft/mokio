require 'bundler/setup'
Bundler.setup

require 'simplecov'
SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../spec/dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
require 'factory_bot_rails'
require 'database_cleaner/active_record'

# Dir['../factories'].each {|f| require f}

# FactoryBot.definition_file_paths = %w(../factories)
# FactoryBot.find_definitions

FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryBot.find_definitions


Rails.backtrace_cleaner.remove_silencers!

# Add this to load Capybara integration:
require 'capybara/rspec'
require 'capybara/rails'

require 'mokio'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
# ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
# ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  # set DatabaseCleaner based on:
  # http://www.virtuouscode.com/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end

  DatabaseCleaner.strategy = :truncation

  config.before(:each) do
    DatabaseCleaner.clean
  end

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :rspec
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.file_fixture_path = "spec/fixtures/files"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "default"

  config.include FactoryBot::Syntax::Methods
  config.include Capybara::DSL
  Capybara.javascript_driver = :selenium
  Capybara.default_max_wait_time = 10

  #
  # Carrierwave files cleanup
  #
  config.after(:each) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end
  end

  #
  # Stubbing out Sunspot during testing
  #

  config.before(:each) do
    ::Sunspot.session = ::Sunspot::Rails::StubSessionProxy.new(::Sunspot.session)

  end

  config.after(:each) do
    ::Sunspot.session = ::Sunspot.session.original_session
  end

  # Authentication

  config.include Devise::Test::ControllerHelpers, :type => :controller


  config.before(:each, :type => :controller) do
    sign_in FactoryBot.create(:user)
  end
end
