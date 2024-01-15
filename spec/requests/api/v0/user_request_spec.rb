require 'rails_helper'
		
describe "Successful User Create request" do
  it "creates a user successfully" do
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

describe "Sad Path Testing" do
  it "tries to create a user with an existing email" do
    post "/api/v0/users", params: {
      user: {
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      }
    }
    user = JSON.parse(response.body, symbolize_names: true)
    expect(user[:status]).to eq(201)

    #now post a second time
    post "/api/v0/users", params: {
      user: {
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      }
    }
    user2 = JSON.parse(response.body, symbolize_names: true)
    expect(user2).to have_key(:status)    
    expect(user2).to have_key(:error_message)

    expect(user2[:status]).to eq(422)
    expect(user2[:error_message]).to eq("This email is already in use.")
  end

  it "tries to create a user with mismatching passwords" do
    post "/api/v0/users", params: {
      user: {
        email: "test@test.com",
        password: "password",
        password_confirmation: "wrong_password"
      }
    }
    user = JSON.parse(response.body, symbolize_names: true)
    
    expect(user).to have_key(:status)    
    expect(user).to have_key(:error_message)

    expect(user[:status]).to eq(422)
    expect(user[:error_message]).to eq("The passwords do not match.")
  end
end