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

    expect(directions).to have_key(:id)
    expect(directions[:id]).to eq(nil)
    expect(directions).to have_key(:type)
    expect(directions[:type]).to be_a(String)
    expect(directions).to have_key(:attributes)
    expect(directions[:attributes]).to be_a(Hash)

    expect(directions[:attributes]).to have_key(:start_city)
    expect(directions[:attributes][:start_city]).to be_a(String)
    expect(directions[:attributes]).to have_key(:end_city)
    expect(directions[:attributes][:end_city]).to be_a(String)
    expect(directions[:attributes]).to have_key(:travel_time)
    expect(directions[:attributes][:travel_time]).to be_a(String)
    expect(directions[:attributes]).to have_key(:weather_at_eta)
    expect(directions[:attributes][:weather_at_eta]).to be_a(Hash)

    expect(directions[:attributes][:weather_at_eta]).to have_key(:datetime)
    expect(directions[:attributes][:weather_at_eta][:datetime]).to be_a(String)
    expect(directions[:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(directions[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(directions[:attributes][:weather_at_eta]).to have_key(:condition)
    expect(directions[:attributes][:weather_at_eta][:condition]).to be_a(String)
  end

  it "does not return irrelevant JSON data" do
    post "/api/v0/road_trip", params: {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "b3uDtIyIRfNO2T5ouMdEpjUTaDNirdke"
    }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    directions_data = JSON.parse(response.body, symbolize_names: true)
    directions = directions_data[:data]

    expect(directions).to_not have_key(:distance)
    expect(directions).to_not have_key(:time)
    expect(directions).to_not have_key(:formattedTime)
    expect(directions).to_not have_key(:hasHighway)
    expect(directions).to_not have_key(:hasTunnel)
  end
end