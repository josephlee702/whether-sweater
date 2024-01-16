require 'rails_helper'

describe WeatherService do
  describe 'class methods' do

    context '#conn' do
      it 'returns a Faraday connection', :vcr do
        conn = WeatherService.conn

        expect(conn).to be_a(Faraday::Connection)
      end
    end

    context '#get_url' do
      it 'returns a parsed response', :vcr do
        response = WeatherService.get_url('http://api.weatherapi.com/v1/forecast.json?q=Indianapolis&aqi=no&days=5')
      end
    end

    context '#get_forecast' do
      it 'returns proper json forecast data', :vcr do
        response = WeatherService.get_forecast("47.73817", "11.02133")

        expect(response).to be_a(Hash)
        expect(response.count).to eq(3)
        expect(response).to have_key(:location)
        expect(response).to have_key(:current)
        expect(response).to have_key(:forecast)

        expect(response[:location]).to have_key(:name)
        expect(response[:location]).to have_key(:region)
        expect(response[:location]).to have_key(:country)
        expect(response[:location]).to have_key(:lat)
        expect(response[:location]).to have_key(:lon)
        expect(response[:location]).to have_key(:tz_id)
        expect(response[:location]).to have_key(:localtime_epoch)
        expect(response[:location]).to have_key(:localtime)

        expect(response[:current]).to have_key(:last_updated_epoch)
        expect(response[:current]).to have_key(:last_updated)
        expect(response[:current]).to have_key(:temp_c)
        expect(response[:current]).to have_key(:temp_f)
        expect(response[:current]).to have_key(:is_day)
        expect(response[:current]).to have_key(:condition)
        expect(response[:current]).to have_key(:wind_mph)
        expect(response[:current]).to have_key(:wind_kph)
        expect(response[:current]).to have_key(:wind_degree)
        expect(response[:current]).to have_key(:wind_dir)
        expect(response[:current]).to have_key(:pressure_mb)
        expect(response[:current]).to have_key(:pressure_in)
        expect(response[:current]).to have_key(:precip_mm)
        expect(response[:current]).to have_key(:precip_in)
        expect(response[:current]).to have_key(:humidity)
        expect(response[:current]).to have_key(:cloud)
        expect(response[:current]).to have_key(:feelslike_c)
        expect(response[:current]).to have_key(:feelslike_f)
        expect(response[:current]).to have_key(:vis_km)
        expect(response[:current]).to have_key(:vis_miles)
        expect(response[:current]).to have_key(:uv)
        expect(response[:current]).to have_key(:gust_mph)
        expect(response[:current]).to have_key(:gust_kph)

        expect(response[:forecast].count).to eq(1)
        expect(response[:forecast]).to have_key(:forecastday)
        expect(response[:forecast][:forecastday].count).to eq(5)

        expect(response[:forecast][:forecastday].first).to have_key(:date)
        expect(response[:forecast][:forecastday].first).to have_key(:date_epoch)
        expect(response[:forecast][:forecastday].first).to have_key(:day)
        expect(response[:forecast][:forecastday].first).to have_key(:astro)
        expect(response[:forecast][:forecastday].first).to have_key(:hour)
      end
    end
  end
end