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
      expect(change.to_s).to eq change.inspect
    end

    it 'supports changes of fields' do
      expect(change.from).to be_nil
      expect(change.to).to eq 23
      expect(change).to_not be_added
    end
  end


  context 'addition change' do
    let :change do
      Fakery::Change.new(name: 'foo', from: nil, to: 23, added: true)
    end

    it 'has nice string representations' do
      expect(change.to_s).to eq change.inspect
    end

    it 'supports changes of fields' do
      expect(change.from).to be_nil
      expect(change.to).to eq 23
      expect(change).to be_added
    end
  end
end
