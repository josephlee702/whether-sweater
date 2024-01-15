class User < ApplicationRecord
  #saves the api key to the user before they are saved into the database
  before_create :generate_api_key
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  private

  def generate_api_key
    #generates a secure,random unique identifier as the user's api_key
    self.api_key = SecureRandom.uuid
  end
end
