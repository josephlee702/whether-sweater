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

  def log_in
    #going against the security tip of not telling what field is incorrect because it narrows a hacker's scope of work, just because I've seen this tip shown and I also think it is helpful for users.
    #however, I can see why we would want to avoid this and give a more general error message. Just due to it's safety, I'd probably follow the security tip provided but for now, I will keep it like this.
    if !User.exists?(email: params[:email])
      render json: no_account_found
    elsif user = User.find_by(email: params[:email])&.authenticate(params[:password])
      render json: successful_log_in(user)
    else
      render json: wrong_password
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

  def successful_log_in(user)
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

  def no_account_found
    {
      status: 404,
      error_message: "There is no account associated with this email."
    }
  end

  def wrong_password
    {
      status: 404,
      error_message: "The password is incorrect for this account."
    }
  end
end
