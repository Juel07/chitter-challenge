require "capybara"
require "capybara/rspec"
require "rspec"
require "simplecov"
require "simplecov-console"

require_relative "./setup_test_database"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start

ENV["RACK_ENV"] = "test"
ENV["ENVIRONMENT"] = "test"

# Bring in the contents of the `app.rb` file. The below is equivalent to: require_relative '../app.rb'
require File.join(File.dirname(__FILE__), "..", "app.rb")

Capybara.app = Chitter

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
