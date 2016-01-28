require 'spec_helper'

describe Fakery::Seeding do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  it 'can be seeded from an URL' do
    url = 'http://api.some.where/foo.json'
    another_fake = fake.dup
    another_fake.name = 'bar'
    expect(Fakery::Api).to receive(:get).and_return(another_fake)
    fake = Fakery.seed url
    expect(fake.name).to eq another_fake.name
    expect(fake.__api_seed_url__).to eq url
  end

  it 'can be reseeded from an URL' do
    url = 'http://api.some.where/foo.json'
    another_fake = fake.dup
    another_fake.name = 'bar'
    fake.__api_seed_url__ = url
    expect(Fakery::Api).to receive(:get).and_return(another_fake)
    Fakery.reseed(fake)
    expect(fake.name).to eq another_fake.name
    expect(fake.__api_seed_url__).to eq url
  end
end
