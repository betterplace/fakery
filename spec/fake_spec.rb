require 'spec_helper'

describe Fakery::Fake do
  let :fake do
    Fakery::Fake.from_hash(name: 'foo')
  end

  context Typhoeus do
    it 'returns a successful http response object' do
      response = fake.http_response
      response.should be_success
      JSON(response.body)['name'].should eq fake.name
    end

    it 'returns an unsuccessful http response object' do
      response = fake.http_response(http_status: 500)
      response.should_not be_success
      JSON(response.body)['name'].should eq fake.name
    end
  end
end

