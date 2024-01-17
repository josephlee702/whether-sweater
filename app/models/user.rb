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

  def self.format_user_response(user)
    {
      status: 201,
      body: {
        data: {
          type: 'users',
          id: user.id,
          attributes: {
            email: user.email,
            api_key: user.api_key
          }
        }
      }
    }
  end

  def self.email_already_exists
    {
      error_message: "This email is already in use.",
      status: 422
    }
  end

  def self.passwords_dont_match
    {
      error_message: "The passwords do not match.",
      status: 422
    }
  end

  def self.successful_log_in(user)
    {
      status: 200,
      body: {
        data: {
          type: 'users',
          id: user.id,
          attributes: {
            email: user.email,
            api_key: user.api_key
          }
        }
      }
    }
  end

  def self.no_account_found
    {
      status: 404,
      error_message: "There is no account associated with this email."
    }
  end

  def self.wrong_password
    {
      status: 404,
      error_message: "The password is incorrect for this account."
    }
  end
end
