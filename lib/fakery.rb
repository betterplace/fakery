require 'set'
require 'tins'
require 'tins/xt/ask_and_send'
require 'json'
require 'typhoeus'
require 'forwardable'

module Fakery
  require 'fakery/version'
  require 'fakery/fakery_error'
  require 'fakery/api_error'
  require 'fakery/api'
  require 'fakery/change'
  require 'fakery/fake'
  require 'fakery/registry'
  require 'fakery/seeding'
  require 'fakery/wrapping'

  class << self
    extend Forwardable

    def_delegators :'Fakery::Registry', :register, :registered?, :build,
      :source

    def_delegators :'Fakery::Seeding', :seed, :reseed

    def_delegators :'Fakery::Wrapping', :http_response, :instance
  end
end
