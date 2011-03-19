require 'ruby_on_etags'
require 'aruba/api'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f; puts f}

RSpec.configure do |config|
  config.include Aruba::Api
end
