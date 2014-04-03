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
      obj.__send__(:changes).should have(1).entry
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
      obj.__send__(:changes).should have(1).entry
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

  it 'can be generated from a file containing JSON text' do
    io = StringIO.new << '{ "name": "foo" }'
    io.rewind
    fake = Fakery::Fake.from_json io
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
end
