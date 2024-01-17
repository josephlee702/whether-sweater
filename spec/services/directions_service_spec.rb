require 'rails_helper'

describe DirectionsService do
  describe 'class methods' do

    context '#conn' do
      it 'returns a Faraday connection', :vcr do
        conn = DirectionsService.conn

        expect(conn).to be_a(Faraday::Connection)
      end
    end

    context '#get_url' do
      it 'returns a parsed response', :vcr do
        response = DirectionsService.get_url('https://www.mapquestapi.com/directions/v2/route?key=b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke&from=Clarendon Blvd,Arlington,VA&to=2400+S+Glebe+Rd,+Arlington,+VA')

        expect(response).to be_a(Hash)
      end
    end

    context '#get_route' do
      it 'returns the desired json data', :vcr do
        response_data = DirectionsService.get_route("denver,co", "chicago,il", "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke")
        response = response_data[:route]

        expect(response).to be_a(Hash)
        expect(response.count).to eq(21)
        expect(response).to have_key(:sessionId)
        expect(response).to have_key(:realTime)
        expect(response).to have_key(:distance)
        expect(response).to have_key(:time)
        expect(response).to have_key(:formattedTime)
        expect(response).to have_key(:hasHighway)
        expect(response).to have_key(:hasTollRoad)
        expect(response).to have_key(:hasBridge)
        expect(response).to have_key(:hasSeasonalClosure)
        expect(response).to have_key(:hasTunnel)
        expect(response).to have_key(:hasFerry)
        expect(response).to have_key(:hasUnpaved)
        expect(response).to have_key(:hasTimedRestriction)
        expect(response).to have_key(:hasUnpaved)
        expect(response).to have_key(:hasCountryCross)
        expect(response).to have_key(:legs)
        expect(response).to have_key(:options)
        expect(response).to have_key(:boundingBox)
        expect(response).to have_key(:name)
        expect(response).to have_key(:maxRoutes)
        expect(response).to have_key(:locations)
        expect(response).to have_key(:locationSequence)
      end
    end
  end
end