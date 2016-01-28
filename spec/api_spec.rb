require 'spec_helper'

describe Fakery::Api do
  context JSON::ParserError do
    before do
      Typhoeus.stub(/.*/).and_return Typhoeus::Response.new(
        code: 200, body: '<nix>json</nix>'
      )
    end

    it 'wraps it into a Fakery::ApiError' do
      expect { Fakery::Api.get('http://foo.bar') }.to raise_error Fakery::ApiError
    end

    it 'has a sensible message' do
      e = Fakery::Api.get('http://foo.bar') rescue $!
      expect(e.message).to match "JSON::ParserError"
      expect(e.message).to match "unexpected token at '<nix>json</nix>'"
    end
  end

  context 'unsuccessful response' do
    before do
      response = Typhoeus::Response.new(
        code: 404, body: '{ "dont": "matter" }'
      )
      allow(response).to receive(:return_message).and_return('curl describes the problem a bit more')
      Typhoeus.stub(/.*/).and_return response
    end


    it 'should raise a Fakery::ApiError' do
      expect { Fakery::Api.get('http://foo.bar') }.to raise_error Fakery::ApiError
    end

    it 'has a sensible message' do
      e = Fakery::Api.get('http://foo.bar') rescue $!
      expect(e.message).to match "api responded with http_status=404 "
      expect(e.message).to match 'curl describes the problem a bit more'
    end
  end
end

