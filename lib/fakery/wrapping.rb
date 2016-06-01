module Fakery::Wrapping
  module_function

  # Return a mocked HTTP response that contains the JSON representation of
  # +fake+ in its body. This response has the status code +http_status+.
  def http_response(fake, type: :typhoeus, http_status: 200)
    fake = Fakery::Fake.cast(fake)
    fake.__send__(:http_response, type: :typhoeus, http_status: http_status)
  end

  # Return an instance of class +as+ initialized with the hash representation
  # of +fake+ (via its constructor).
  def instance(fake, as:, with: nil)
    as or raise ArgumentError, 'as keyword argument is required'
    fake = Fakery::Fake.cast(fake)
    with and fake = Fakery::Fake.cast(fake.to_hash.merge(with))
    as.new(fake.to_hash)
  end
end
