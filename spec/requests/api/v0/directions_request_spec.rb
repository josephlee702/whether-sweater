require 'rails_helper'
		
describe "Directions Request API" do
  it "returns road trip directions JSON data" do
    post "/api/v0/road_trip", params: {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke"
    }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    directions_data = JSON.parse(response.body, symbolize_names: true)
    directions = directions_data[:data]
  end

  xit "does not return irrelevant JSON data" do
    location = create(:location)
    get "/api/v0/forecast?location=#{location.city},#{location.state}"

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