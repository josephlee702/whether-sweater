class Api::V0::DirectionsController < ApplicationController
  def road_trip
    directions = DirectionsFacade.get_route(params[:origin], params[:destination], params[:api_key])
    render json: DirectionsSerializer.format_directions(directions)
  end
end