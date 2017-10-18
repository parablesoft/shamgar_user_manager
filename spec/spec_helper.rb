require "bundler/setup"
require 'fixtures/application'
require "shamgar_user_manager"
require 'fixtures/controllers'
require "airborne"
require 'ffaker'
require "database_cleaner"
require "factory_girl"
require 'rspec/rails'
require "byebug"
require 'jsonapi-serializers'
require 'shoulda/matchers'

Dir["spec/serializers/**/*.rb"].each {|f| load f}
Dir["spec/factories/**/*.rb"].each {|f| load f}

load "spec/fixtures/database.rb"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.include FactoryGirl::Syntax::Methods

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end


  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
