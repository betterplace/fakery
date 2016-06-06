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
      expect(obj.__send__(:changes)).to be_empty
      obj.name = 'bar'
      expect(obj.__send__(:changes).size).to eq 1
      change = obj.__send__(:changes).first
      expect(change.name).to eq :name
      expect(change.from).to eq 'foo'
      expect(change.to).to eq 'bar'
      expect(change).to_not be_added
    end

    it 'records addition changes' do
      obj = Fakery.build(:foo)
      expect(obj.__send__(:changes)).to be_empty
      obj.change = true
      expect(obj.__send__(:changes).size).to eq 1
      change = obj.__send__(:changes).first
      expect(change.name).to eq :change
      expect(change.from).to be_nil
      expect(change.to).to eq true
      expect(change).to be_added
    end

    it 'can ignore changes' do
      obj = Fakery.build(:foo)
      expect(obj.__send__(:changes)).to be_empty
      Fakery::Fake.ignore_changes do
        obj.change = true
      end
      expect(obj.__send__(:changes)).to be_empty
    end
  end

  it 'can be generated from a JSON text' do
    fake = Fakery::Fake.from_json '{ "name": "foo" }'
    expect(fake).to be_a Fakery::Fake
    expect(fake.name).to eq 'foo'
  end

  context 'casting' do
    it 'casts to itself' do
      casted = Fakery::Fake.cast(fake)
      expect(casted).to be_a Fakery::Fake
      expect(casted.name).to eq 'foo'
    end

    it 'casts from a name to a registered fake' do
      casted = Fakery::Fake.cast(:foo)
      expect(casted).to be_a Fakery::Fake
      expect(casted.name).to eq 'foo'
    end

    it 'casts from a hash to a fake' do
      casted = Fakery::Fake.cast(name: 'foo')
      expect(casted).to be_a Fakery::Fake
      expect(casted.name).to eq 'foo'
    end

    it 'casts from a json text to a fake' do
      casted = Fakery::Fake.cast('{ "name": "foo" }')
      expect(casted).to be_a Fakery::Fake
      expect(casted.name).to eq 'foo'
    end

    it 'casts from a file containing json text to a fake' do
      io = StringIO.new << '{ "name": "foo" }'
      fake = Fakery::Fake.cast(io.tap(&:rewind))
      expect(fake).to be_a Fakery::Fake
      expect(fake.name).to eq 'foo'
    end

    it 'casts from an object implementing as_json method' do
      object = double(as_json: { name: 'foo' })
      casted = Fakery::Fake.cast(object)
      expect(casted).to be_a Fakery::Fake
      expect(casted.name).to eq 'foo'
    end

    it 'raises an ArgumentError if it cannot cast' do
      expect { Fakery::Fake.cast(Object.new) }.to raise_error ArgumentError
    end
  end
end
