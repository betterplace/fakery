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
    expect(Fakery::Registry).to receive(:warn).with(any_args).and_call_original
    Fakery.register 'foo', fake
    Fakery.register 'foo', fake
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
  end
end
