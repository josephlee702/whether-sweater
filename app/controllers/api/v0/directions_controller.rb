class Api::V0::DirectionsController < ApplicationController
  def road_trip
    if params[:api_key].blank?
      render json: {status: 401, error_message: "Unauthorized" }, status: 401
    elsif params[:origin].blank? || params[:destination].blank?
      render json: { status: 400, error_message: "Please fill out all fields."}
    else
      render json: DirectionsFacade.get_route(params[:origin], params[:destination])
    end
  end
end