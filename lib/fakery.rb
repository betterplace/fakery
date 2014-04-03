require 'set'
require 'tins'
require 'json'
require 'typhoeus'
require 'forwardable'

module Fakery
  require 'fakery/fakery_error'
  require 'fakery/api_error'
  require 'fakery/api'
  require 'fakery/change'
  require 'fakery/fake'
  require 'fakery/registry'
  require 'fakery/version'

  class << self
    extend Forwardable

    def_delegators :'Fakery::Registry', :seed, :register, :registered?, :build
  end
end
