require 'rails_helper'
		
describe "Munchies API" do
  it "returns restaurant JSON data" do
    get "/api/v1/munchies?location=pueblo,co&term=italian"

    expect(response).to be_successful
    
    location_data = JSON.parse(response.body, symbolize_names: true)
    location = location_data[:data]

    expect(location).to have_key(:id)
    expect(location[:id]).to eq(nil)
    expect(location).to have_key(:type)
    expect(location[:type]).to eq("munchie")
    expect(location).to have_key(:attributes)

    expect(location[:attributes]).to have_key(:destination_city)
    expect(location[:attributes][:destination_city]).to be_a(String)
    expect(location[:attributes][:destination_city]).to eq("Pueblo,CO")

    expect(location[:attributes]).to have_key(:forecast)
    expect(location[:attributes][:forecast]).to be_an(Hash)

    expect(location[:attributes][:forecast]).to have_key(:summary)
    expect(location[:attributes][:forecast]).to have_key(:temperature)

    expect(location[:attributes][:restaurant]).to have_key(:name)
    expect(location[:attributes][:restaurant][:name]).to be_a(String)
    expect(location[:attributes][:restaurant]).to have_key(:address)
    expect(location[:attributes][:restaurant][:address]).to be_a(String)
    expect(location[:attributes][:restaurant]).to have_key(:rating)
    expect(location[:attributes][:restaurant][:rating]).to be_a(Float)
    expect(location[:attributes][:restaurant]).to have_key(:reviews)
    expect(location[:attributes][:restaurant][:reviews]).to be_a(Integer)
  end
end