require 'set'
require 'tins'
require 'json'

module Fakery
  require 'fakery/api'
  require 'fakery/api_error'
  require 'fakery/change'
  require 'fakery/fake'
  require 'fakery/fakery_error'
  require 'fakery/registry'
  require 'fakery/version'

  class << self
    extend Forwardable

    def_delegators :'Fakery::Registry', :seed, :register, :registered_stubs, :build
  end
end
