module Fakery::Api
  module_function

  def get(url, params: {})
    response = Typhoeus.get(url, params: params)
    if response.success?
      JSON.parse response.body, object_class: JSON::GenericObject
    else
      raise ApiError.new(
        "api responded with #{response.code}",
        response: response
      )
    end
  rescue JSON::ParserError => e
    raise ApiError.new(e.message, response: response)
  end
end
