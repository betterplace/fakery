require 'simplecov'
require "codeclimate-test-reporter"
if ENV['START_SIMPLECOV'].to_i == 1
  SimpleCov.start do
    add_filter "#{File.basename(File.dirname(__FILE__))}/"
  end
elsif ENV['CODECLIMATE_REPO_TOKEN']
  CodeClimate::TestReporter.start
end
require 'rspec'
require 'byebug'
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
