require 'spec_helper'

describe Fakery::Registry do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  it 'registers fakes under a name' do
    expect(Fakery).to_not be_registered 'foo'
    expect(Fakery).to_not be_registered :foo
    Fakery.register 'foo', fake
    expect(Fakery).to be_registered 'foo'
    expect(Fakery).to be_registered :foo
  end

  it 'warns iff a fake was registered a second time' do
    expect(Fakery::Registry).to receive(:warn).with(any_args)
    Fakery.register 'foo', fake
    Fakery.register 'foo', fake
  end

  it 'can register files containing json as fakes' do
    expect(File).to receive(:read).with('bar/foo.json').and_return fake.to_json
    Fakery.register_files 'bar/foo.json'
    expect(Fakery.build(:foo).name).to eq 'foo'
  end

  context 'registered fake' do
    before :each do
      Fakery.register :foo, fake
    end

    it 'cannot be built if not registered' do
      expect { Fakery.build(:bar) }.to raise_error ArgumentError
    end

    it 'can be built' do
      foo = Fakery.build(:foo)
      expect(foo.name).to eq 'foo'
      expect(foo.bar).to be_nil
    end

    it 'can be changed and registered again' do
      foo = Fakery.build(:foo, with: { bar: true })
      expect(foo.bar).to eq true
      Fakery.register(:bar, foo)
      expect(Fakery.build(:bar).bar).to eq true
    end

    it 'can be listed' do
      expect(Fakery::Registry.list).to eq %i[ foo ]
    end
  end
end
