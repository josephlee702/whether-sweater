class Api::V0::DirectionsController < ApplicationController
  def road_trip
    #user = User.find_by(api_key: params[:api_key])
    #couldn't get the scenario of the API key being incorrect...maybe it's something small i can't seem to get? The secure part of the api key seems to be messing up the line above and I can't use it to check using something like a `!user` condition...
    if params[:api_key].blank?
      render json: {status: 401, error_message: "Unauthorized" }
    elsif params[:origin].blank? || params[:destination].blank?
      render json: { status: 400, error_message: "Please fill out all fields."}
    else
      render json: DirectionsFacade.get_route(params[:origin], params[:destination], params[:api_key])
    end
  end
end