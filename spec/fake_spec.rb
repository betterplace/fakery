require 'spec_helper'
require 'stringio'

describe Fakery::Fake do
  let! :fake do
    fake = Fakery::Fake.from_hash(name: 'foo')
    Fakery.register(:foo, fake)
    fake
  end

  context Fakery::Change do
    it 'records regular changes' do
      obj = Fakery.build(:foo)
      obj.__send__(:changes).should be_empty
      obj.name = 'bar'
      expect(obj.__send__(:changes).size).to eq 1
      change = obj.__send__(:changes).first
      change.name.should eq :name
      change.from.should eq 'foo'
      change.to.should eq 'bar'
      change.should_not be_added
    end

    it 'records addition changes' do
      obj = Fakery.build(:foo)
      obj.__send__(:changes).should be_empty
      obj.change = true
      expect(obj.__send__(:changes).size).to eq 1
      change = obj.__send__(:changes).first
      change.name.should eq :change
      change.from.should be_nil
      change.to.should eq true
      change.should be_added
    end

    it 'can ignore changes' do
      obj = Fakery.build(:foo)
      obj.__send__(:changes).should be_empty
      Fakery::Fake.ignore_changes do
        obj.change = true
      end
      obj.__send__(:changes).should be_empty
    end
  end

  it 'can be generated from a JSON text' do
    fake = Fakery::Fake.from_json '{ "name": "foo" }'
    fake.should be_a Fakery::Fake
    fake.name.should eq 'foo'
  end

  it 'can output ruby code for registration in the Fake::Registry' do
    string = Fakery.source(:my_name, fake)
    string.should be_a String
    Fakery.should_not be_registered :my_name
    eval(string)
    Fakery.should be_registered :my_name
    Fakery.build(:my_name).name.should eq 'foo'
  end

  context 'casting' do
    it 'casts to itself' do
      casted = Fakery::Fake.cast(fake)
      casted.should be_a Fakery::Fake
      casted.name.should eq 'foo'
    end

    it 'casts from a name to a registered fake' do
      Fakery.register(:foo, fake)
      casted = Fakery::Fake.cast(:foo)
      casted.should be_a Fakery::Fake
      casted.name.should eq 'foo'
    end

    it 'casts from a hash to a fake' do
      casted = Fakery::Fake.cast(name: 'foo')
      casted.should be_a Fakery::Fake
      casted.name.should eq 'foo'
    end

    it 'casts from a json text to a fake' do
      casted = Fakery::Fake.cast('{ "name": "foo" }')
      casted.should be_a Fakery::Fake
      casted.name.should eq 'foo'
    end

    it 'casts from a file containing json text to a fake' do
      io = StringIO.new << '{ "name": "foo" }'
      fake = Fakery::Fake.cast(io.tap(&:rewind))
      fake.should be_a Fakery::Fake
      fake.name.should eq 'foo'
    end

    it 'raises an ArgumentError if it cannot cast' do
      expect { Fakery::Fake.cast(Object.new) }.to raise_error ArgumentError
    end
  end
end
