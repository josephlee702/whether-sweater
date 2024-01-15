class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if User.exists?(email: user.email)
      render json: email_already_exists(user)
    elsif user.password != user.password_confirmation
      render json: passwords_dont_match(user)
    elsif user.save
      render json: format_user_response(user)
    else
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def format_user_response(user)
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

  def email_already_exists(user)
    {
      error_message: "This email is already in use.",
      status: 422
    }
  end

  def passwords_dont_match(user)
    {
      error_message: "The passwords do not match.",
      status: 422
    }
  end
end
