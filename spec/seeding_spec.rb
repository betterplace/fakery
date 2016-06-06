require 'spec_helper'

describe Fakery::Seeding do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  let :another_fake do
    f = fake.dup
    f.name = 'bar'
    f
  end

  before do
    expect(Fakery::Api).to receive(:get).and_return(another_fake)
  end

  it 'can be seeded from an URL' do
    url = 'http://api.some.where/foo.json'
    fake = Fakery.seed url
    expect(fake.name).to eq another_fake.name
    expect(fake.__api_seed_url__).to eq url
  end

  it 'can be seeded from an URL and registered' do
    url = 'http://api.some.where/foo.json'
    fake = Fakery.seed url, register: :foo
    expect(Fakery.build(:foo).name).to eq another_fake.name
    expect(Fakery.build(:foo).__api_seed_url__).to eq url
  end

  it 'can be reseeded from its original URL' do
    url = 'http://api.some.where/foo.json'
    fake.__api_seed_url__ = url
    Fakery.reseed(fake)
    expect(fake.name).to eq another_fake.name
    expect(fake.__api_seed_url__).to eq url
  end

  it 'can be reseeded from an URL' do
    url = 'http://api.some.where/foo.json'
    Fakery.reseed(fake, url: url)
    expect(fake.name).to eq another_fake.name
    expect(fake.__api_seed_url__).to eq url
  end

  it 'can be reseeded from an URL and registered' do
    url = 'http://api.some.where/foo.json'
    fake.__api_seed_url__ = url
    Fakery.reseed(fake, register: :foo)
    expect(Fakery.build(:foo).name).to eq another_fake.name
    expect(Fakery.build(:foo).__api_seed_url__).to eq url
  end

  it 'can be reseeded from an URL and registered under its previous name' do
    url = 'http://api.some.where/foo.json'
    Fakery.register :foo, fake
    expect(Fakery.build(:foo).name).to eq fake.name
    expect(Fakery::Registry).to receive(:warn).with(any_args)
    Fakery.reseed(:foo, url: url, register: true)
    expect(Fakery.build(:foo).name).to eq another_fake.name
  end
end
