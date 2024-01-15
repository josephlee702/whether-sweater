class Api::V0::DirectionsController < ApplicationController
  def road_trip(location1, location2)
    DirectionsFacade.get_route(location1, location2)
  end
end