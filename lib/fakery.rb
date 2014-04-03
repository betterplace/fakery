require 'set'
require 'tins'
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

    def cast(fake)
      case
      when Fakery::Fake === fake
        fake
      when registered?(fake)
        build(fake)
      when Hash === fake
        Fake.from_hash(fake)
      else
        Fake.from_json(fake)
      end
    end

    def_delegators :'Fakery::Registry', :register, :registered?, :build,
      :source

    def_delegators :'Fakery::Seeding', :seed, :reseed

    def_delegators :'Fakery::Wrapping', :http_response, :instance
  end
end
