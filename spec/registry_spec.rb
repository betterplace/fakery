require 'spec_helper'

describe Fakery::Registry do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  it 'registers fakes under a name' do
    Fakery.should_not be_registered 'foo'
    Fakery.should_not be_registered :foo
    Fakery.register 'foo', fake
    Fakery.should be_registered 'foo'
    Fakery.should be_registered :foo
  end

  it 'warns iff a fake was registered a second time' do
    Fakery::Registry.should receive(:warn).with(any_args).and_call_original
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
      foo.name.should eq 'foo'
      foo.bar.should be_nil
    end

    it 'can be changed and registered again' do
      foo = Fakery.build(:foo, with: { bar: true })
      foo.bar.should eq true
      Fakery.register(:bar, foo)
      Fakery.build(:bar).bar.should eq true
    end
  end
end
