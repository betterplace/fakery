module Fakery::Api
  module_function

  # Get a http response from +url+ with parameters +params+.
  def get_response(url, params: {})
    Typhoeus.get(url, params: params)
  end

  # Get the +url+ and parse the response body into a Fakery::Fake object. If
  # this is unsuccessful or an invalid JSON text is returned, this method will
  # throw a Fakery::ApiError exception.
  def get(url, params: {})
    response = get_response(url, params: params)
    if response.success?
      JSON.parse response.body, object_class: Fakery::Fake
    else
      raise Fakery::ApiError.new(
        "api responded with http_status=#{response.code} "\
        "message=#{response.return_message.inspect}",
        response: response
      )
    end
  rescue JSON::ParserError => e
    raise Fakery::ApiError.new(
      "#{e.class}: #{e.message}",
      response: response
    )
  end
end
