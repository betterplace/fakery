module Fakery::Api
  module_function

  def get_response(url, params: {})
    Typhoeus.get(url, params: params)
  end

  def get(url, params: {})
    response = get_response(url, params: params)
    if response.success?
      JSON.parse response.body, object_class: JSON::GenericObject
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
