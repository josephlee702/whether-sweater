require 'rails_helper'
		
describe "User Create" do
  it "creates a user" do
    post "/api/v0/users", params: {
      user: {
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      }
    }
    expect(response).to be_successful

    user = JSON.parse(response.body, symbolize_names: true)
    user_data = user[:body][:data]

    expect(user[:status]).to eq(201)

    expect(user_data).to have_key(:id)
    expect(user_data).to have_key(:type)
    expect(user_data).to have_key(:attributes)

    expect(user_data[:id]).to be_an(Integer)
    expect(user_data[:type]).to eq("users")
    
    expect(user_data[:attributes]).to have_key(:email)
    expect(user_data[:attributes]).to have_key(:api_key)
    expect(user_data[:attributes][:email]).to eq("test@test.com")
    expect(user_data[:attributes][:api_key]).to be_a(String)

    expect(user_data[:attributes]).to_not have_key(:password)
    expect(user_data[:attributes]).to_not have_key(:password_confirmation)
  end
end