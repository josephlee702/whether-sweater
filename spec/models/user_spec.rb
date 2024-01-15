require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) } 
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  describe "callbacks" do
    it "should generate an api_key before creating a user" do
      user = User.create(email: "test@test.com", password: "123", password_confirmation: "123")

      expect(user.api_key).to be_present
    end
  end
end