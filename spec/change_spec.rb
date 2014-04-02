require 'spec_helper'

describe Fakery::Change do
  it 'raises ArgumentError if arguments are missing' do
    expect { Fakery::Change.new }.to raise_error ArgumentError
  end

  context 'regular change' do
    let :change do
      Fakery::Change.new(name: 'foo', from: nil, to: 23)
    end

    it 'has nice string representations' do
      change.to_s.should eq change.inspect
    end

    it 'supports changes of fields' do
      change.from.should be_nil
      change.to.should eq 23
      change.should_not be_added
    end
  end


  context 'addition change' do
    let :change do
      Fakery::Change.new(name: 'foo', from: nil, to: 23, added: true)
    end

    it 'has nice string representations' do
      change.to_s.should eq change.inspect
    end

    it 'supports changes of fields' do
      change.from.should be_nil
      change.to.should eq 23
      change.should be_added
    end
  end
end
