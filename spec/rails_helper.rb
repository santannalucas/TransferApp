ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec', 'factories', '**', '*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec', 'controllers', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end