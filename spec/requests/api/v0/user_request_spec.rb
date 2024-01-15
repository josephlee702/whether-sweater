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

describe "User Creation Sad Path Testing" do
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

describe "Successful User Create request" do
  it "logs in successfully" do
    post "/api/v0/users", params: {
      user: {
        email: "whatever25@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }
    user_data = JSON.parse(response.body, symbolize_names: true)
    user = User.find_by(id: user_data[:body][:data][:id])

    post "/api/v0/sessions", params: {
        "email": "whatever25@example.com",
        "password": "password"
    }

    good_log_in_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(good_log_in_data).to have_key(:status)    
    expect(good_log_in_data[:status]).to be(200) 
    expect(good_log_in_data).to have_key(:body)

    good_log_in = good_log_in_data[:body][:data][:attributes]

    expect(good_log_in).to have_key(:email)
    expect(good_log_in[:email]).to eq(user.email)
    expect(good_log_in).to have_key(:api_key)
  end
end

describe "Unsuccessful User Create request" do
  it "tries to use invalid email" do
    post "/api/v0/sessions", params: {
        "email": "whatever@example.com",
        "password": "password"
    }

    wrong_email = JSON.parse(response.body, symbolize_names: true)
    
    expect(wrong_email).to have_key(:status)
    expect(wrong_email[:status]).to eq(404)
    expect(wrong_email).to have_key(:error_message)
    expect(wrong_email[:error_message]).to eq("There is no account associated with this email.")
  end

  it "tries to use invalid email" do
    post "/api/v0/users", params: {
      user: {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }

    user_data = JSON.parse(response.body, symbolize_names: true)
    user = User.find_by(id: user_data[:body][:data][:id])

    post "/api/v0/sessions", params: {
        "email": "whatever@example.com",
        "password": "WRONG_PASSWORD"
    }

    wrong_password = JSON.parse(response.body, symbolize_names: true)
    
    expect(wrong_password).to have_key(:status)
    expect(wrong_password[:status]).to eq(404)
    expect(wrong_password).to have_key(:error_message)
    expect(wrong_password[:error_message]).to eq("The password is incorrect for this account.")
  end
end