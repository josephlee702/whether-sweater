class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if User.exists?(email: user.email)
      render json: User.email_already_exists
    elsif user.password != user.password_confirmation
      render json: User.passwords_dont_match
    elsif user.save
      render json: User.format_user_response(user)
    else
    end
  end

  def log_in
    #going against the security tip of not telling what field is incorrect because it narrows a hacker's scope of work, just because I've seen this tip shown and I also think it is helpful for users.
    #however, I can see why we would want to avoid this and give a more general error message. Just due to it's safety, I'd probably follow the security tip provided but for now, I will keep it like this.
    if !User.exists?(email: params[:email])
      render json: User.no_account_found
    elsif user = User.find_by(email: params[:email])&.authenticate(params[:password])
      render json: User.successful_log_in(user)
    else
      render json: User.wrong_password
    end
  end
    
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
