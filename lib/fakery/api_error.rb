class Fakery::ApiError
  def initialize(*args, **opts)
    super(*args)
    @response = opts[:response]
  end

  attr_reader :response
end
