require 'rails_helper'
		
describe "Forecast API" do
  it "returns forecast JSON data", :vcr do    
    get "/api/v0/forecast", params: {
      location: "Denver,CO",
    }

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)
    forecast_data = forecast[:data]

    expect(forecast_data).to have_key(:id)
    expect(forecast_data[:id]).to eq(nil)
    expect(forecast_data).to have_key(:type)
    expect(forecast_data[:type]).to eq("forecast")
    expect(forecast_data).to have_key(:attributes)
    expect(forecast_data[:attributes]).to have_key(:current_weather)
    expect(forecast_data[:attributes][:current_weather]).to be_a(Hash)
    expect(forecast_data[:attributes][:current_weather].count).to eq(8)

    expect(forecast_data[:attributes]).to have_key(:daily_weather)
    expect(forecast_data[:attributes][:daily_weather]).to be_an(Array)
    expect(forecast_data[:attributes][:daily_weather].count).to eq(5)

    expect(forecast_data[:attributes]).to have_key(:hourly_weather)
    expect(forecast_data[:attributes][:hourly_weather]).to be_an(Array)
    expect(forecast_data[:attributes][:hourly_weather].count).to eq(24)
  end

  it "does not return irrelevant JSON data", :vcr do
    get "/api/v0/forecast", params: {
      location: "Denver,CO",
    }

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)
    forecast_data = forecast[:data]

    expect(forecast_data[:attributes]).to_not have_key(:location)
    expect(forecast_data[:attributes][:current_weather]).to_not have_key(:temp_c)
    expect(forecast_data[:attributes][:current_weather]).to_not have_key(:is_day)
    expect(forecast_data[:attributes][:current_weather]).to_not have_key(:wind_mph)
    expect(forecast_data[:attributes][:current_weather]).to_not have_key(:wind_dir)

    expect(forecast_data[:attributes][:daily_weather].first).to_not have_key(:maxwind_mph)
    expect(forecast_data[:attributes][:daily_weather].first).to_not have_key(:totalprecip_in)
    expect(forecast_data[:attributes][:daily_weather].first).to_not have_key(:daily_chance_of_rain)

    expect(forecast_data[:attributes][:hourly_weather].first).to_not have_key(:wind_mph)
    expect(forecast_data[:attributes][:hourly_weather].first).to_not have_key(:wind_dir)
    expect(forecast_data[:attributes][:hourly_weather].first).to_not have_key(:humidity)
  end
end