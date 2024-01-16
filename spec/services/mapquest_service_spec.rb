require 'rails_helper'

describe MapquestService do
  describe 'class methods' do

    context '#conn' do
      it 'returns a Faraday connection', :vcr do
        conn = MapquestService.conn

        expect(conn).to be_a(Faraday::Connection)
      end
    end

    context '#get_url' do
      it 'returns a parsed response', :vcr do
        response = MapquestService.get_url('https://www.mapquestapi.com/geocoding/v1/address?key=b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke&location=Denver,CO')

        expect(response).to be_a(Hash)
        expect(response.count).to eq(3)
        expect(response).to have_key(:info)
        expect(response).to have_key(:options)
        expect(response).to have_key(:results)

        expect(response[:info]).to have_key(:statuscode)
        expect(response[:info]).to have_key(:copyright)
        expect(response[:info]).to have_key(:messages)
        expect(response[:info].count).to eq(3)

        expect(response[:options]).to have_key(:maxResults)
        expect(response[:options]).to have_key(:ignoreLatLngInput)

        expect(response[:results].count).to eq(1)
        expect(response[:results].first).to have_key(:providedLocation)
        expect(response[:results].first).to have_key(:locations)

        expect(response[:results].first[:providedLocation]).to have_key(:location)
        expect(response[:results].first[:locations]).to be_an(Array)
        expect(response[:results].first[:locations].count).to eq(1)
        expect(response[:results].first[:locations].first).to have_key(:street)
        expect(response[:results].first[:locations].first).to have_key(:adminArea6)
        expect(response[:results].first[:locations].first).to have_key(:adminArea6Type)
        expect(response[:results].first[:locations].first).to have_key(:adminArea5)
        expect(response[:results].first[:locations].first).to have_key(:adminArea5Type)
        expect(response[:results].first[:locations].first).to have_key(:adminArea4)
        expect(response[:results].first[:locations].first).to have_key(:adminArea4Type)
        expect(response[:results].first[:locations].first).to have_key(:adminArea3)
        expect(response[:results].first[:locations].first).to have_key(:adminArea3Type)
        expect(response[:results].first[:locations].first).to have_key(:adminArea1)
        expect(response[:results].first[:locations].first).to have_key(:adminArea1Type)
        expect(response[:results].first[:locations].first).to have_key(:postalCode)
        expect(response[:results].first[:locations].first).to have_key(:geocodeQualityCode)
        expect(response[:results].first[:locations].first).to have_key(:geocodeQuality)
        expect(response[:results].first[:locations].first).to have_key(:dragPoint)
        expect(response[:results].first[:locations].first).to have_key(:sideOfStreet)
        expect(response[:results].first[:locations].first).to have_key(:linkId)
        expect(response[:results].first[:locations].first).to have_key(:unknownInput)
        expect(response[:results].first[:locations].first).to have_key(:type)
        expect(response[:results].first[:locations].first).to have_key(:latLng)
        expect(response[:results].first[:locations].first).to have_key(:displayLatLng)
        expect(response[:results].first[:locations].first).to have_key(:mapUrl)
      end
    end
  end
end