require 'spec_helper'

describe Fakery::Seeding do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  it 'can be seeded from an URL' do
    url = 'http://api.some.where/foo.json'
    another_fake = fake.dup
    another_fake.name = 'bar'
    Fakery::Api.should_receive(:get).and_return(another_fake)
    fake = Fakery.seed url
    fake.name.should eq another_fake.name
    fake.__api_seed_url__.should eq url
  end

  it 'can be reseeded from an URL' do
    url = 'http://api.some.where/foo.json'
    another_fake = fake.dup
    another_fake.name = 'bar'
    fake.__api_seed_url__ = url
    Fakery::Api.should_receive(:get).and_return(another_fake)
    Fakery.reseed(fake)
    fake.name.should eq another_fake.name
    fake.__api_seed_url__.should eq url
  end
end
