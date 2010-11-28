require 'ruby_on_etags'
require 'aruba/api'

RSpec.configure do |config|
  config.include Aruba::Api
end
