require 'rails_helper'

describe BookService do
  describe 'class methods' do

    context '#conn' do
      it 'returns a Faraday connection', :vcr do
        conn = BookService.conn

        expect(conn).to be_a(Faraday::Connection)
      end
    end

    context '#get_url' do
      it 'returns a parsed response', :vcr do
        response = BookService.get_url('https://openlibrary.org/search.json?title=denver,co&limit=2')

        expect(response).to be_a(Hash)
      end
    end

    context '#get_book' do
      it 'gets back book json data', :vcr do
        response = BookService.get_book("Denver,CO", "2")

        expect(response).to be_a(Hash)
        expect(response.count).to eq(7)
        expect(response).to have_key(:numFound)
        expect(response).to have_key(:start)
        expect(response).to have_key(:numFoundExact)
        expect(response).to have_key(:docs)
        expect(response).to have_key(:num_found)
        expect(response).to have_key(:q)
        expect(response).to have_key(:offset)
      end
    end
  end
end