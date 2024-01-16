require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) } 
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  describe "callbacks" do
    describe "#generate_api_key" do
      it "should generate an api_key before creating a user" do
        user = User.create(email: "test@test.com", password: "123", password_confirmation: "123")

        expect(user.api_key).to be_present
      end
    end
  end

  describe "class methods" do
    describe "#format_user_response" do
      it "should return proper json data" do
        user = User.create(email: "test@test.edu", password: "123", password_confirmation: "123", api_key: "12312312131231231")

        response = User.format_user_response(user)
        expect(response).to have_key(:status)
        expect(response).to have_key(:body)

        expect(response[:body]).to have_key(:data)
        expect(response[:body][:data]).to have_key(:type)
        expect(response[:body][:data][:type]).to eq("users")
        expect(response[:body][:data]).to have_key(:id)
        expect(response[:body][:data]).to have_key(:attributes)
        expect(response[:body][:data][:attributes]).to have_key(:email)
        expect(response[:body][:data][:attributes][:email]).to eq("test@test.edu")
        expect(response[:body][:data][:attributes]).to have_key(:api_key)
      end
    end

    describe "#email_already_exists" do
      it "should return proper error message" do
        response = User.email_already_exists

        expect(response).to have_key(:error_message)
        expect(response[:error_message]).to eq("This email is already in use.")
        expect(response).to have_key(:status)
        expect(response[:status]).to eq(422)
      end
    end

    describe "#passwords_dont_match" do
      it "should return proper error message" do
        response = User.passwords_dont_match
        
        expect(response).to have_key(:error_message)
        expect(response[:error_message]).to eq("The passwords do not match.")
        expect(response).to have_key(:status)
        expect(response[:status]).to eq(422)
      end
    end

    describe "#successful_log_in" do
      it "should return proper json response" do
        user = User.create(email: "test@test.edu", password: "123", password_confirmation: "123", api_key: "12312312131231231")

        response = User.successful_log_in(user)

        expect(response).to have_key(:status)
        expect(response[:status]).to eq(200)
        expect(response).to have_key(:body)
        expect(response[:body]).to have_key(:data)
        expect(response[:body][:data]).to have_key(:type)
        expect(response[:body][:data]).to have_key(:id)
        expect(response[:body][:data]).to have_key(:attributes)

        expect(response[:body][:data][:attributes]).to have_key(:email)
        expect(response[:body][:data][:attributes][:email]).to eq("test@test.edu")
        expect(response[:body][:data][:attributes]).to have_key(:api_key)
      end
    end

    describe "#no_account_found" do
      it "should return proper error message" do
        response = User.no_account_found

        expect(response).to have_key(:error_message)
        expect(response[:error_message]).to eq("There is no account associated with this email.")
        expect(response).to have_key(:status)
        expect(response[:status]).to eq(404)
      end
    end

    describe "#wrong_password" do
      it "should return proper error message" do
        response = User.wrong_password

        expect(response).to have_key(:error_message)
        expect(response[:error_message]).to eq("The password is incorrect for this account.")
        expect(response).to have_key(:status)
        expect(response[:status]).to eq(404)
      end
    end
  end
end