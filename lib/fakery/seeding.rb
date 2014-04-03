module Fakery::Seeding
  module_function

  # TODO
  def seed(api_seed_url)
    Fakery::Fake.seed_from_url(api_seed_url)
  end

  # TODO
  def reseed(fake, url = nil)
    url and fake.__api_seed_url__ = url
    fake.__send__(:seed!)
  end
end
