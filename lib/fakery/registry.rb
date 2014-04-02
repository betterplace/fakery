module Fakery::Registry
  module_function

  def registered_stubs
    @registered_stubs ||= {}
  end

  def register(register_name, api_stub)
    register_name = register_name.to_sym
    if registered_stubs.key?(register_name)
      warn "WARNING: Overwriting api stub for already registered name #{register_name.inspect}."
    end
    registered_stubs[register_name] =
      Fakery::Fake === api_stub ? api_stub : Fakery::Fake.from_json(api_stub)
  end

  def build(register_name, with: {})
    register_name = register_name.to_sym
    api_stub = registered_stubs.fetch(register_name).dup
    for (name, value) in with
      api_stub[name] = value
    end
    api_stub
  rescue KeyError
    raise ArgumentError, "no stub registered under name #{register_name.inspect}"
  end

  def seed(api_seed_url)
    Fakery::Fake.seed_from_url(api_seed_url)
  end
end
