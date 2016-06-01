require 'spec_helper'

describe Fakery::Wrapping do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  describe 'http_response' do
    context Typhoeus do
      it 'returns a successful http response object' do
        response = Fakery.http_response(fake)
        expect(response).to be_success
        expect(JSON(response.body)['name']).to eq fake.name
      end

      it 'returns an unsuccessful http response object' do
        response = Fakery.http_response(fake, http_status: 500)
        expect(response).to_not be_success
        expect(JSON(response.body)['name']).to eq fake.name
      end

      context 'registered' do
        before :each do
          Fakery.register :foo, fake
        end

        it 'returns a http response object' do
          response = Fakery.http_response(:foo)
          expect(JSON(response.body)['name']).to eq fake.name
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
      expect(obj.attrs[:name]).to eq fake.name
    end

    context 'registered' do
      before :each do
        Fakery.register :foo, fake
      end

      it 'returns an instance' do
        obj = Fakery.instance(:foo, as: klass)
        expect(obj.attrs[:name]).to eq fake.name
      end

      it 'returns a modified instance' do
        obj = Fakery.instance(:foo, as: klass, with: { name: 'bar' })
        expect(obj.attrs[:name]).to eq 'bar'
      end
    end
  end
end
