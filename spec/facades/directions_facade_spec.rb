require 'rails_helper'
		
describe "Directions Facade" do
  describe "#get_route", :vcr do
    it "returns proper JSON data", :vcr do
      response = DirectionsFacade.get_route("denver,co", "chicago,il", "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke")
      response_data = response[:data]

      expect(response_data).to have_key(:id)
      expect(response_data[:id]).to eq(nil)
      expect(response_data).to have_key(:type)
      expect(response_data[:type]).to eq("road_trip")
      expect(response_data).to have_key(:attributes)

      expect(response_data[:attributes]).to have_key(:start_city)
      expect(response_data[:attributes][:start_city]).to eq("denver,co")
      expect(response_data[:attributes]).to have_key(:end_city)
      expect(response_data[:attributes][:end_city]).to eq("chicago,il")
      expect(response_data[:attributes]).to have_key(:travel_time)
      expect(response_data[:attributes][:travel_time]).to be_a(String)
      expect(response_data[:attributes]).to have_key(:weather_at_eta)

      expect(response_data[:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(response_data[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(response_data[:attributes][:weather_at_eta]).to have_key(:condition)
    end
  end

  describe "#format_directions", :vcr do
    it "returns proper JSON data", :vcr do
      response = DirectionsFacade.format_directions(WeatherFacade.get_forecast("chicago,il"), DirectionsService.get_route("denver,co", "chicago,il", "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke")[:route], "denver,co", "chicago,il")

      expect(response).to be_a(Hash)
    end
  end

  describe "#travel_time_from_seconds", :vcr do
    it "returns proper JSON data", :vcr do
      response = DirectionsFacade.travel_time_from_seconds(DirectionsService.get_route("Denver,CO", "Fort Collins, CO", "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke")[:route], 100)
      expect(response).to eq("00:01:40")
    end
  end

  describe "#datetime_at_eta", :vcr do
    it "returns proper JSON data", :vcr do
      response = DirectionsFacade.datetime_at_eta(DirectionsService.get_route("denver,co", "chicago,il", "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke")[:route])

      expect(response).to eq("2024-01-17 08:45")
    end
  end

  describe "#temperature_at_eta", :vcr do
    it "returns proper JSON data", :vcr do
      response = DirectionsFacade.temperature_at_eta(WeatherFacade.get_forecast("chicago,il"), DirectionsService.get_route("denver,co", "chicago,il", "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke")[:route])

      expect(response).to be_an(Array)
    end
  end

  describe "#condition_at_eta", :vcr do
    it "returns proper JSON data", :vcr do
      response = DirectionsFacade.condition_at_eta(WeatherFacade.get_forecast("chicago,il"), DirectionsService.get_route("denver,co", "chicago,il", "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke")[:route])

      expect(response).to be_an(Array)
    end
  end
end