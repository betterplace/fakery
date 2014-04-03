module Fakery::Wrapping
  module_function

  def http_response(fake, type: :typhoeus, http_status: 200)
    fake = Fakery.cast(fake)
    fake.__send__(:http_response, type: :typhoeus, http_status: http_status)
  end

  def instance(fake, as: nil) # TODO remove nil in Ruby 2.1
    as or raise ArgumentError,
      'as keyword argument is required'
    fake = Fakery.cast(fake)
    as.new(fake.to_hash)
  end
end
