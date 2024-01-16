require 'rails_helper'
		
describe "Weather Facade" do
  describe "#get_forecast", :vcr do
    it "returns forecast JSON data" do
      response = WeatherFacade.get_forecast("denver,co")

      expect(response[:data]).to be_a(Hash)
      expect(response[:data].count).to eq(3)
      expect(response[:data]).to have_key(:id)
      expect(response[:data][:id]).to eq(nil)
      expect(response[:data]).to have_key(:type)
      expect(response[:data][:type]).to eq("forecast")
      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:attributes]).to be_a(Hash)
      expect(response[:data][:attributes].count).to eq(3)

      expect(response[:data][:attributes]).to have_key(:current_weather)
      expect(response[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(response[:data][:attributes][:current_weather].count).to eq(8)

      expect(response[:data][:attributes]).to have_key(:daily_weather)
      expect(response[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(response[:data][:attributes][:daily_weather].count).to eq(5)

      expect(response[:data][:attributes]).to have_key(:hourly_weather)
      expect(response[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(response[:data][:attributes][:hourly_weather].count).to eq(24)

      expect(response[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(response[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(response[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(response[:data][:attributes][:current_weather]).to have_key(:"humidity,")
      expect(response[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(response[:data][:attributes][:current_weather]).to have_key(:visibility_miles)
      expect(response[:data][:attributes][:current_weather]).to have_key(:condition)
      expect(response[:data][:attributes][:current_weather]).to have_key(:icon)

      expect(response[:data][:attributes][:daily_weather].first).to have_key(:date)
      expect(response[:data][:attributes][:daily_weather].first).to have_key(:sunrise)
      expect(response[:data][:attributes][:daily_weather].first).to have_key(:sunset)
      expect(response[:data][:attributes][:daily_weather].first).to have_key(:max_temp)
      expect(response[:data][:attributes][:daily_weather].first).to have_key(:min_temp)
      expect(response[:data][:attributes][:daily_weather].first).to have_key(:condition)

      expect(response[:data][:attributes][:hourly_weather].first).to have_key(:time)
      expect(response[:data][:attributes][:hourly_weather].first).to have_key(:temperature)
      expect(response[:data][:attributes][:hourly_weather].first).to have_key(:conditions)
      expect(response[:data][:attributes][:hourly_weather].first).to have_key(:icon)
    end
  end

  describe "#build_forecast_data", :vcr do
    it "returns forecast JSON data" do
      forecast = WeatherService.get_forecast("47.73817","11.02133")
      response = WeatherFacade.build_forecast_data(forecast)

      expect(response).to have_key(:data)
      expect(response[:data]).to have_key(:id)
      expect(response[:data]).to have_key(:type)
      expect(response[:data]).to have_key(:attributes)
      expect(response[:data][:id]).to eq(nil)
      expect(response[:data][:type]).to eq("forecast")
      expect(response[:data][:attributes]).to have_key(:current_weather)
      expect(response[:data][:attributes]).to have_key(:daily_weather)
      expect(response[:data][:attributes]).to have_key(:hourly_weather)
    end
  end

  describe "#format_current_weather", :vcr do
    it "returns forecast JSON data" do
      forecast = WeatherService.get_forecast("47.73817","11.02133")
      response = WeatherFacade.format_current_weather(forecast[:current])

      expect(response).to have_key(:last_updated)
      expect(response).to have_key(:temperature)
      expect(response).to have_key(:feels_like)
      expect(response).to have_key(:"humidity,")
      expect(response).to have_key(:uvi)
      expect(response).to have_key(:visibility_miles)
      expect(response).to have_key(:condition)
      expect(response).to have_key(:icon)
      expect(response).to have_key(:last_updated)
    end
  end

  describe "#format_daily_weather", :vcr do
    it "returns forecast JSON data" do
      forecast = WeatherService.get_forecast("47.73817","11.02133")
      response = WeatherFacade.format_daily_weather(forecast[:forecast][:forecastday])

      expect(response).to be_an(Array)
      expect(response.first).to have_key(:date)
      expect(response.first).to have_key(:sunrise)
      expect(response.first).to have_key(:sunset)
      expect(response.first).to have_key(:max_temp)
      expect(response.first).to have_key(:min_temp)
      expect(response.first).to have_key(:condition)
      expect(response.first).to have_key(:icon)
    end
  end

  describe "#format_hourly_weather", :vcr do
    it "returns forecast JSON data" do
      forecast = WeatherService.get_forecast("47.73817","11.02133")
      response = WeatherFacade.format_hourly_weather(forecast[:forecast][:forecastday].first[:hour])

      expect(response).to be_an(Array)
      expect(response.first).to have_key(:time)
      expect(response.first).to have_key(:temperature)
      expect(response.first).to have_key(:conditions)
      expect(response.first).to have_key(:icon)
    end
  end
end