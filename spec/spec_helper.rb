require 'bundler/setup'
require 'monzo2qif'

RSpec.configure do |config|
  config.order = :random

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
