module Fakery::Wrapping
  module_function

  def http_response(fake, type: :typhoeus, http_status: 200)
    fake = Fakery.cast(fake)
    fake.__send__(:http_response, type: :typhoeus, http_status: http_status)
  end
end
