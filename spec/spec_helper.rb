$:.unshift File.join(File.dirname(__FILE__), '../lib')
require 'scamp-campfire'

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

RSpec.configure do |config|
  config.color_enabled = true
  config.mock_framework = :mocha
end
