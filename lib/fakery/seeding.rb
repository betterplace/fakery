module Fakery::Seeding
  module_function

  # Seed a fake from the JSON returned by +api_seed_url+. If a name was passed
  # via +register+ option the fake is registered under that name.
  def seed(api_seed_url, register: nil)
    fake = Fakery::Fake.seed_from_url(api_seed_url)
    register and Fakery::Registry.register register, fake
    fake
  end

  # Reseed the fake (also the name of a registered fake) given as  +fake+ from
  # its original +api_seed_url+ or from the URL passed as +url+ option. If the
  # +register+ option is true and the fake was registered the newly seeded fake
  # will be registered under its original name again. If +register+ was a name
  # this name will be used instead.
  def reseed(fake, url: nil, register: true)
    if register == true
      if Fakery::Registry.registered?(fake)
        register = fake
      else
        register = nil
      end
    end
    fake = Fakery::Fake.cast(fake)
    url and fake.__api_seed_url__ = url
    register and Fakery::Registry.register register, fake
    fake.__send__(:reseed)
  end
end
