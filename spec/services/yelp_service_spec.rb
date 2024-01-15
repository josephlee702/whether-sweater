require 'rails_helper'

describe YelpService do
  describe 'class methods' do

    context '#conn' do
      it 'returns a Faraday connection' do
        conn = YelpService.conn

        expect(conn).to be_a(Faraday::Connection)
      end
    end

    context '#get_url' do
      it 'returns a parsed response' do
        response = YelpService.get_url('https://api.yelp.com/v3/businesses/search')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:error)
      end
    end
  end
end
