require 'spec_helper'

describe Fakery::Wrapping do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  describe 'http_response' do
    context Typhoeus do
      it 'returns a successful http response object' do
        response = Fakery.http_response(fake)
        response.should be_success
        JSON(response.body)['name'].should eq fake.name
      end

      it 'returns an unsuccessful http response object' do
        response = Fakery.http_response(fake, http_status: 500)
        response.should_not be_success
        JSON(response.body)['name'].should eq fake.name
      end

      context 'registered' do
        before :each do
          Fakery.register :foo, fake
        end

        it 'returns a http response object' do
          response = Fakery.http_response(:foo)
          JSON(response.body)['name'].should eq fake.name
        end
      end
    end
  end

  describe 'instance' do
    let :klass do
      Class.new do
        def initialize(attrs)
          @attrs = attrs
        end

        attr_reader :attrs
      end
    end

    it 'returns an instance' do
      obj = Fakery.instance(fake, as: klass)
      obj.attrs[:name].should eq fake.name
    end

    context 'registered' do
      before :each do
        Fakery.register :foo, fake
      end

      it 'returns an instance' do
        obj = Fakery.instance(:foo, as: klass)
        obj.attrs[:name].should eq fake.name
      end
    end
  end
end
