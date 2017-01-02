if ENV['START_SIMPLECOV'].to_i == 1
  require 'simplecov'
  SimpleCov.start do
    add_filter "#{File.basename(File.dirname(__FILE__))}/"
  end
end
require 'rspec'
begin
  require 'byebug'
rescue LoadError
  warn "Cannot load byebug => Skipping it."
end
require 'fakery'

RSpec.configure do |config|
  config.before(:each) do
    Typhoeus::Config.block_connection = true
  end

  config.after(:each) do
    Typhoeus::Expectation.clear
    Fakery::Registry.clear
  end
end
